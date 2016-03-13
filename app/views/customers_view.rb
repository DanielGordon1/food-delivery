class CustomersView

  def list_all_customers(customers)
    customers.each do |customer|
      puts "[#{customer.id}] -- customer: #{customer.name}\naddress: #{customer.address}"
    end
  end

  def ask_customer_name
    puts "What is the name of the customer you want to add?"
    return gets.chomp
  end

  def ask_customer_address
    puts "What is the address of the customer you want to add?"
    return gets.chomp
  end

  def ask_customer_id
    puts "What is the id of the customer you want to delete?"
    return gets.chomp.to_i
  end
end
