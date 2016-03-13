require 'csv'
require_relative '../models/employee'


class EmployeeRepository
  attr_reader :employees

  def initialize(filepath)
    @filepath = filepath
    @employees = []
    read_from_csv
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.user_name == username }
  end

  def read_from_csv
    @next_id    = 0
    csv_options = { headers: :first_row, header_converters: :symbol }
     CSV.foreach(@filepath, csv_options) do |row|
      employee = Employee.new(
        id:        row[:id].to_i,
        name:      row[:name],
        user_name: row[:user_name],
        password:  row[:password],
        manager:   row[:manager] == "true"
        )
      @next_id = employee.id
      @employees << employee
    end
    @next_id += 1
  end

  def all
    return @employees
  end
end
