class Item < ApplicationRecord

  belongs_to :genre, optional: true
  attachment :image

  enum is_active: { on_sale: true, sold_out: false}

end
