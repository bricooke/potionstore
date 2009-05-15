class Store::FreebiesController < ApplicationController
  layout "store"
  before_filter :redirect_to_ssl
  before_filter :validate_order_and_coupon
  
  def new
  end

  def create
    # enter their information then email them and send them to the thanks
    @order.order_time = Time.now()
    @order.status = 'C'
    @order.attributes = params[:order]
    
    if !@order.valid?
      render :action => :new
    else
      if params[:subscribe] && params[:subscribe] == 'checked'
        @order.subscribe_to_list()
      end

      @order.save
      @order.email_receipt_when_finishing = true
      @order.finish_and_save()

      session[:order_id] = @order.id
      redirect_to :controller => 'store/order', :action => 'thankyou'    
    end
  end

protected
  def validate_order_and_coupon
    @order = Order.find_by_id(session[:order_id])
    if session[:order_id].nil? || @order.total > 0 || @order.line_items.size == 0 || @order.coupon.nil?
      # something doesn't smell right.
      flash[:notice] = "Invalid order or coupon"
      redirect_to '/'
    end
  end
end
