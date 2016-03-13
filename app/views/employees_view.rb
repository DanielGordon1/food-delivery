class EmployeesView

  def list_all_employees(employees)
    employees.each do |employee|
      puts "[#{employee.id}] -- user_name:#{employee.user_name}\n name: #{employee.name} manager:#{employee.manager}"
    end
  end
end
