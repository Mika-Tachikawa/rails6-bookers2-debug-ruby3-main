class ApplicationController < ActionController::Base
  #, except: [:top ,:about]の
  before_action :authenticate_user!, except: [:top ,:about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    #リダイレクト先の変更
    #root_path
    #user_path(current_user.id) 
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
