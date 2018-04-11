class Accessory < ApplicationRecord
  validates_presence_of :description, :price, :role
  validates_presence_of :title, uniqueness: :true
end
