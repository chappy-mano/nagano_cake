class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details, allow_destroy: true #fields_forに必要

  enum payment_method: {
    クレジットカード: 0,
    銀行振込: 1
  }

  attr_accessor :address_status

  enum address_status: {
    ご自身の住所: 0,
    登録済住所から選択: 1,
    新しいお届け先: 2
  }

  enum status: {
    入金待ち: 0,
    入金確認: 1,
    製作中: 2,
    発送準備中: 3,
    発送済み: 4
  }

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :payment_method, presence: true

  end
