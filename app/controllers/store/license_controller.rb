class Store::LicenseController < ApplicationController
  
  def validate
    logger.info "[LICENSE VALIDATION] User: '#{params[:license][:name]}' Key: '#{params[:license][:key]}'"
    
    if !params[:license][:key].blank? && params[:license][:key].length > 1
      render :text => "OK"
    else
      # give them a 404
      raise ActiveRecord::RecordNotFound
    end
  end

end
