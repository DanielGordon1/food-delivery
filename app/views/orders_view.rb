require_relative '../models/order'
class OrdersView

  def list_all_orders(orders)
    orders.each do |order|
      if order.delivered == true
        puts "Delivered: [X]\n[#{order.id}] -- order:#{order.meal}\n delivered: #{order.delivered}"
      else
        puts "Delivered: [ ]\n[#{order.id}] -- order:#{order.meal}\n delivered: #{order.delivered}"
      end
    end
  end

  def ask_for_meal
    puts "Give a description of the meal"
    return gets.chomp
  end

  def ask_for_employee
    puts "Which employee do you want to assign the meal to?\nPlease provide the employee [id]"
    return gets.chomp.to_i
  end

  def ask_for_customer
    puts "Which customer do you want to assign to the order?\nPlease provide the customer [id]"
    return gets.chomp.to_i
  end

  def ask_order_id
    puts "What is the [id] of the order you want to delete?"
    return gets.chomp.to_i
  end

  def ask_id_to_be_delivered
    puts "What is the [id] of the order you want to mark as delivered?"
    return gets.chomp.to_i
  end
end
