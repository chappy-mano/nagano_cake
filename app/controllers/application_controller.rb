class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?
  
  #管理者がログイン後に、商品一覧へ飛ぶ設定。
  #顧客がログイン後は、マイページに飛ぶよう設定の必要あり
  def after_sign_in_path_for(resource)
    admin_items_path(resource)
  end

end
