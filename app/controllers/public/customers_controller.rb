class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def confirm
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true) #退会フラグを立てる
    reset_session #ログアウトさせる
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしていおります。"
    redirect_to root_path
    # current_customer.is_deleted = true
    # sign_out_and_redirect(current_customer)
  end

end
