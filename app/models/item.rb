class Item < ApplicationRecord

  belongs_to :genre, optional: true
  has_many :cart_items, dependent: :destroy
  attachment :image
  enum is_active: { 販売中:true, 売切れ:false}
  
end
