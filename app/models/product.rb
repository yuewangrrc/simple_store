class Product < ApplicationRecord
  belongs_to :category
  
  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
