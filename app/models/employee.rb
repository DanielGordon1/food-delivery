class Employee
  attr_accessor :id, :name, :orders, :manager
  attr_reader :password, :user_name
  def initialize(attributes = {})
    @id         = attributes[:id]
    @name       = attributes[:name]
    @user_name  = attributes[:user_name]
    @password   = attributes[:password]
    @manager    = attributes[:manager] || false
    @orders     = []
  end

  def remove_order(order)
    @orders.delete(order)
  end

  def change_to_manager
    @manager = true
  end
end


