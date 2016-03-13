class Order

  attr_accessor :id, :delivered, :meal
  attr_reader :customer, :employee

  def initialize(attributes = {})
    @id        = attributes[:id]
    @meal      = attributes[:meal]
    @delivered = attributes[:delivered] || false
    @customer  = nil
    @employee  = nil
  end

  def assign_to_employee(employee)
    @employee = employee
    employee.orders << self
  end

  def assign_to_customer(customer)
    @customer = customer
    customer.orders << self
  end
end
