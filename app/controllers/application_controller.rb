class ApplicationController < ActionController::Base

  # def after_sign_in_path_for(resource)
  #   case resource
  #   when Admin
  #     admin_orders_path(sort: 0)
  #   when Customer
  #     customers_path
  #   end
  # end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_orders_path(sort: 0)
    elsif resource.is_a?(Customer)
      customers_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    elsif resource == :customer
      root_path
    end
  end



  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number])
  end


end
