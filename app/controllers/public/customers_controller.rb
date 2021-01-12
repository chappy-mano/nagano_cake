class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def confirm
  end

  def withdraw
    current_customer.is_deleted = true
    sign_out_and_redirect(current_customer)
  end

end
