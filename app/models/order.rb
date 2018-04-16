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

  def self.ordered_count
    where(status: 'Ordered').count
  end

  def self.paid_count
    where(status: 'Paid').count
  end

  def self.completed_count
    where(status: 'Completed').count
  end

  def self.cancelled_count
    where(status: 'Cancelled').count
  end
end
