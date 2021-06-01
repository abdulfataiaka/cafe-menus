class UploadsController < ApplicationController
  def show
    send_file "#{Rails.root}/storage#{request.path}", disposition: "inline" 
    # raise ActionController::RoutingError.new('Not Found')
  end
end
