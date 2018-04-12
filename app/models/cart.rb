require './app/models/accessory'

class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_accessory(id)
    contents[id.to_s] = contents[id.to_s] + 1
  end

  def count_of(id)
    contents[id.to_s].to_i
  end

  def items
    items = []
    contents.each_pair do |key, value|
      accessory = Accessory.find(key)
      items.push({ accessory: accessory, quantity: value })
    end
    items
  end

  def subtotal(accessory)
    accessory[:accessory][:price] * contents[accessory[:accessory][:id].to_s]
  end

  def total_accessory_value
    values = []
    contents.each_pair do |key, value|
      values << Accessory.find(key).price * value
    end
    values.sum
  end
end
