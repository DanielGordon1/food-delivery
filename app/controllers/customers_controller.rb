require_relative '../models/customer'
require_relative '../repositories/customer_repository'
require_relative '../views/customers_view'

class CustomersController

  def initialize(customer_repository)
    @customer_repository  = customer_repository
    @view = CustomersView.new
  end

  def list_customers
    @view.list_all_customers(@customer_repository.all)
  end

  def create_customer
    customer_name = @view.ask_customer_name
    customer_address = @view.ask_customer_address
    customer = Customer.new(name: customer_name, address: customer_address)
    @customer_repository.add_customer(customer)
  end

  def delete_customer
    customer_id = @view.ask_customer_id
    customer = @customer_repository.find(customer_id)
    @customer_repository.remove_customer(customer)
  end
end
