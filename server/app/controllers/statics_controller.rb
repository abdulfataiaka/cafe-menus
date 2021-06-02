class StaticsController < ApplicationController
  def root
    path = Rails.root.join('public/client/index.html')
    raise_not_found unless File.exist?(path)
    send_file path, type: 'text/html', disposition: "inline"
  end

  def uploads
    path = Rails.root.join("storage#{request.path}")
    raise_not_found unless File.exist?(path)
    send_file path, disposition: "inline" 
  end

  def client
    path = Rails.root.join("public/client#{request.path}")
    raise_not_found unless File.exist?(path)
    send_file path, disposition: "inline" 
  end

  private

  def raise_not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
