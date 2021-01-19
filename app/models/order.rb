class Order < ApplicationRecord

  belongs_to :customer

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

  end
