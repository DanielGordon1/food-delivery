# TODO: implement the router of your app
require_relative 'app/controllers/orders_controller'
require_relative 'app/controllers/customers_controller'
require_relative 'app/controllers/employees_controller'

class Router
  def initialize(customer_repository, order_repository, employee_repository)
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @order_repository = order_repository
    @running  = true
  end

  def run
    @employees_controller = EmployeesController.new(@employee_repository)
    @customers_controller = CustomersController.new(@customer_repository)
    @orders_controller    = OrdersController.new(@order_repository, @employee_repository, @customer_repository)


    puts "Welcome to the Restaurant delivery system!"
    puts "                   --                     "
    user_name = login
    if user_name == false
      @running = false
    elsif @employees_controller.manager?(user_name) == true
      while @running == true
        display_tasks_manager
        action = gets.chomp.to_i
        print `clear`
        route_action_manager(action)
      end
    elsif @employees_controller.manager?(user_name) == "delivery_guy"
      while @running == true
        display_tasks_delivery_guy
        action = gets.chomp.to_i
        print `clear`
        route_action_delivery_guy(action)
      end
    end
  end

  def login
    loop do
      puts "         What is your user_name"
      user_name = gets.chomp
      if @employees_controller.check_username(user_name) == true
        puts "       What is your password?"
        password = gets.chomp
        if @employees_controller.check_password(user_name, password) == true
          return user_name
        else
          return false
        end
      end
    end
  end

  def display_tasks_manager
    puts ""
    puts "What do you want to do?"
    puts "1 - List all employees."
    puts "2 - List all orders."
    puts "3 - Create an order."
    puts "4 - Delete an order."
    puts "5 - Mark an order as delivered."
    puts "6 - List all customers."
    puts "7 - Create a customer."
    puts "8 - Delete a customer."
    puts "9 - Stop and exit the program."
  end

  def display_tasks_delivery_guy
    puts ""
    puts "What do you want to do?"
    puts "1 - List all orders"
    puts "2 - Mark an order as delivered"
    puts "3 - Stop and exit the program"
  end

  def route_action_manager(action)
    case action
    when 1 then @employees_controller.list_employees
    when 2 then @orders_controller.list_orders
    when 3 then @orders_controller.create_order
    when 4 then @orders_controller.delete_order
    when 5 then @orders_controller.mark_as_delivered
    when 6 then @customers_controller.list_customers
    when 7 then @customers_controller.create_customer
    when 8 then @customers_controller.delete_customer
    when 9 then stop
    end
  end

  def route_action_delivery_guy(action)
    case action
    when 1 then @orders_controller.list_orders
    when 2 then @orders_controller.mark_as_delivered
    when 3 then stop
    end
  end

  def stop
    @running = false
  end
end
