class Customer
  attr_accessor :id, :name, :address, :orders
  def initialize(attributes = {})
    @id      = attributes[:id]
    @name    = attributes[:name]
    @address = attributes[:address]
    @orders  = []
  end

  def remove_order(order)
    @orders.delete(order)
  end
end
