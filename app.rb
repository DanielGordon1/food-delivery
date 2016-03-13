# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#    $ ruby app.rb

require_relative 'app/models/customer'
require_relative 'app/models/employee'
require_relative 'app/models/order'
require_relative 'app/repositories/employee_repository'
require_relative 'app/repositories/customer_repository'
require_relative 'app/repositories/order_repository'
# require_relative 'app/controllers/employees_controller'
# require_relative 'app/controller/orders_controller'
require_relative 'router'

# filepath = File.join(__dir__, 'data/employees.csv')
# p employee_repository


employee_repository = EmployeeRepository.new('data/employees.csv')
customer_repository = CustomerRepository.new('data/customers.csv')
order_repository = OrderRepository.new('data/orders.csv', employee_repository, customer_repository)

router = Router.new(customer_repository, order_repository, employee_repository)
# jack  = Employee.new(name: 'Jack', user_name: 'jack', password: "12345")

router.run
# order_repository.add_order(pasta)


# pasta.assign_to_customer(bob)

# p customer_repository
# p employee_repository

# p customer_repository


# p order_repository

#


# p rick
# p james

# rick.manager

# p rick
# p pasta

# @employees.all



