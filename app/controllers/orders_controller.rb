require_relative '../models/order'
require_relative '../repositories/order_repository'
require_relative '../repositories/employee_repository'
require_relative '../repositories/customer_repository'
require_relative '../views/orders_view'

class OrdersController

  def initialize(order_repository, employee_repository, customer_repository)
    @order_repository     = order_repository
    @employee_repository  = employee_repository
    @customer_repository  = customer_repository
    @view = OrdersView.new
  end

  def list_orders
    @view.list_all_orders(@order_repository.all)
  end

  def create_order
    mealname    = @view.ask_for_meal
    meal        = Order.new(meal: mealname)

    employee_id = @view.ask_for_employee
    employee    = @employee_repository.find(employee_id)

    meal.assign_to_employee(employee)

    customer_id = @view.ask_for_customer
    customer    = @customer_repository.find(customer_id)

    meal.assign_to_customer(customer)

    @order_repository.add_order(meal)
  end

  def delete_order
    order_id = @view.ask_order_id
    order    = @order_repository.find(order_id)
    @order_repository.remove_order(order)
  end

  def mark_as_delivered
    order_id = @view.ask_id_to_be_delivered
    order    = @order_repository.find(order_id)
    @order_repository.mark_as_delivered(order)
  end
end
