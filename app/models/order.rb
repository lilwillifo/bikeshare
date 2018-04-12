class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user

  has_many :order_accessories
  has_many :accessories, through: :order_accessories

  def total
    order_accessories.reduce(0) do |sum, item|
      sum + (item.quantity * item.accessory.price)
    end
  end
end