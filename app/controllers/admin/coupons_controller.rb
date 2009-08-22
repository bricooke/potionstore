class Admin::CouponsController < ApplicationController
  layout "admin"

  before_filter :redirect_to_ssl, :check_authentication
  
  def index
    @coupons = Coupon.find(:all, :order => "created_at DESC")
  end
  
  def new
    @coupon = Coupon.new
  end
  
  def create  
    form = params[:coupon]
    @coupons = []
    1.upto(Integer(form[:quantity])) { |i|
      coupon = Coupon.new
      coupon.code = form[:code]
      coupon.coupon = form[:coupon] unless form[:coupon].blank? || form[:quantity] != 1
      coupon.product_code = form[:product_code]
      coupon.description = form[:description]
      coupon.amount = form[:amount]
      coupon.use_limit = form[:use_limit]
      coupon.expiration_date = form[:expiration_date]
      coupon.save()
      @coupons << coupon
    }
    flash[:notice] = 'Coupons generated'
    redirect_to :action => 'index'
  end

  def edit
    @coupon = Coupon.find_by_id(params[:id])
  end

  def update
    @coupon = Coupon.find_by_id(params[:id])
    @coupon.update_attributes(params[:coupon])
    
    if @coupon.save
      flash[:notice] = "Coupon updated"
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
  
  
  def destroy
    Coupon.find_by_id(params[:id]).destroy
    flash[:notice] = "Coupon deleted"
    redirect_to admin_coupons_path
  end

end
