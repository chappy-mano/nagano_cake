class Address < ApplicationRecord

  belongs_to :customers, optional: true
end
