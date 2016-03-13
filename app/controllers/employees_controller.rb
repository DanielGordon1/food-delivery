require_relative '../models/employee'
require_relative '../repositories/employee_repository'
require_relative '../views/employees_view'

class EmployeesController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = EmployeesView.new
  end

  def list_employees
    @view.list_all_employees(@employee_repository.all)
  end

  def check_username(user_name)
    employee = @employee_repository.find_by_username(user_name)
    if employee.user_name == user_name
      return true
    else
      return false
    end
  end

  def check_password(user_name, password)
    employee = @employee_repository.find_by_username(user_name)
    if employee.password == password
      return true
    else
      return false
    end
  end

  def manager?(user_name)
    employee = @employee_repository.find_by_username(user_name)
    if employee.manager == true
      return true
    else
      return "delivery_guy"
    end
  end
end
