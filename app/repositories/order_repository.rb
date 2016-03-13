require 'csv'
require_relative 'customer_repository'
require_relative 'employee_repository'
require_relative '../models/order'

class OrderRepository
  def initialize(filepath, employee_repository, customer_repository)
    @filepath = filepath
    @customer_repository =  customer_repository
    @employee_repository =  employee_repository
    @orders = []

    load_from_csv
  end

  def add_order(order)
    order.id = @next_id
    @orders << order

    @next_id += 1

    write_to_csv
  end

  def mark_as_delivered(order)
    order.delivered = true
    write_to_csv
  end

  def remove_order(order)
    @orders.delete(order)
    write_to_csv
  end

  def all
    return @orders
  end

  def find(id)
    @orders.find { |order| order.id == id }
  end

  def load_from_csv
    @next_id = 0
    csv_options = {headers: :first_row, header_converters: :symbol }
      CSV.foreach(@filepath, csv_options) do |row|
        #Order:
        # => id: 1
        # => meal: asd
        # => customer_id: 4
        order   = Order.new(
          id:    row[:id].to_i,
          meal:  row[:meal],
          delivered: row[:delivered] == "true"
          )
        customer = @customer_repository.find(row[:customer_id].to_i)
        order.assign_to_customer(customer)
        employee = @employee_repository.find(row[:employee_id].to_i)
        order.assign_to_employee(employee)
        @next_id = order.id
        @orders << order
      end
    @next_id += 1
  end

  def write_to_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@filepath, 'wb', csv_options) do |csv|
      csv << ['id', 'meal', 'customer_id', 'employee_id', 'delivered']

      @orders.each do |order|
        csv << [order.id, order.meal, order.customer.id, order.employee.id, order.delivered]
      end
    end
  end
end
