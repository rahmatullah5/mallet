class ApplicationController < ActionController::Base
  before_action :set_user, :authenticate_logged_user!
  
  def set_user
    @current_logged_user = current_user || current_stock || current_team || current_admin
  end

  private 

  def check_role
    raise ActionController::RoutingError.new('Not Found') if @current_logged_user.class.to_s.eql?("Admin")
  end

  def authenticate_logged_user!
    class_name = @current_logged_user  ? @current_logged_user.class.to_s.downcase : 'user'
    eval("authenticate_#{class_name}!")
  end
end
