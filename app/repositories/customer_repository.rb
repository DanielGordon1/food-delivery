require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(filepath)
    @filepath = filepath
    @customers = []
    read_from_csv
  end

  def find(id)
    @customers.find { |customer| customer.id == id }
  end

  def add_customer(customer)
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    write_to_csv
  end

  def write_to_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@filepath, 'w', csv_options) do |csv|
        csv << ['id', 'name', 'address','orders']

        @customers.each do |customer|
          csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def read_from_csv
    @next_id    = 0
    csv_options = { headers: :first_row, header_converters: :symbol }
     CSV.foreach(@filepath, csv_options) do |row|
      customer = Customer.new(
        id:        row[:id].to_i,
        name:      row[:name],
        address:   row[:address],
        orders:    row[:orders]
        )
      @next_id = customer.id
      @customers << customer
    end
    @next_id += 1
  end

  def all
    return @customers
  end

  def remove_customer(customer)
    @customers.delete(customer)
    write_to_csv
  end
end

