require 'pry'
# - user chooses from a list of main dishes
# - user chooses 2 side dish items
# - computer repeats users order
# - computer totals lunch items and displays total
# - user can choose as many "add-on" items as they want before getting total
# - user can clear their choices and start over
# - user has a wallet total they start with and their choices cannot exceed what they can pay for
# - program is in a loop to keep asking the user to make new orders until they type 'quit' at any time
# - main dishes and side items have descriptions with them and the user has an option to view the description before they order (hint: think hashes)
# - descriptions of food can have multiple options like nutritional facts, calories, fat content ect...(hint: think nested hashes)
# - display to the user not only their total but the total fat content / calories / carbs / ect...
# - have an option to display
@user_main_order = []
@user_side_order = []

@main = [
  {item: "Pizza", price: 5.00, calories: 600},
  {item: "Cheeseburger", price: 4.00, calories: 500},
  {item: "Caesar Salad", price: 3.00, calories: 300}
]

@side = [
  {item: "French Fries", price: 2.00, calories: 300},
  {item: "Side Salad", price: 3.00, calories: 350},
  {item: "Soup of the Day", price: 2.00, calories: 200}
]

def main_menu
  puts " |DPL Cafe|"
  puts "  |Item | Price | Calories|"
  menu_options
end

def menu_options
  puts "\n|Main Dishes|"
    @main.each { |x, i| puts "  #{x[:item]} |" " $#{x[:price]} |" " #{x[:calories]}" }
  puts "\n\n|Side Dishes|"
    @side.each { |x, i| puts "  #{x[:item]} |" " $#{x[:price]} |" " #{x[:calories]}" }
end

def options
  puts "\n | DPL Cafe |"
  puts "Please choose from the following:"
  puts "1: DPL Cafe Menu"
  puts "2: Order"
  puts "3: Quit\n"
end

def main_order
  @user_main_order
  puts "\nWhich main dish would you like?"
  puts "\n|Main Dishes|"
    @main.each_with_index { |x, i| puts "#{i + 1}. #{x[:item]} |" " $#{x[:price]} |" " #{x[:calories]}" }
    main_order = gets.strip.to_i - 1 #because pizza is in 0 index
    case main_order
    when (0..10)
      @user_main_order << @main[main_order]
      puts "You added #{@user_main_order[0][:item]}."
  #binding.pry
  end
end

def side_order
  @user_side_order
  puts "\nWhich side dish would you like?"
  puts "\n|Side Dishes|"
    @side.each_with_index { |x, i| puts "#{i + 1}. #{x[:item]} |" " $#{x[:price]} |" " #{x[:calories]}" }
  side_order = gets.strip.to_i - 1
  case side_order
  when (0..10)
    @user_side_order << @side[side_order]
    puts "You added #{@user_side_order[0][:item]}."
  end
end

def repeat_order
  puts "\nYour order contains: #{@user_main_order[0][:item]}, #{@user_side_order[0][:item]}, #{@user_side_order[1][:item]}."
  puts "\nAre you ready to check-out? Y or N"
  check = gets.strip.downcase
  if check == 'y'
  checkout
  elsif check == 'n'
  not_ready
  else
    menu
  end
end

def not_ready
  puts "Cancel order? Y or N"
  user_cancel = gets.strip.downcase
  if user_cancel == 'y'
    puts "Goodbye! Thanks for coming in!"
    exit
  else checkout
  end
end

def checkout
  @total = @user_main_order[0][:price] + @user_side_order[0][:price] + @user_side_order[1][:price]
  puts "\nYour total is: "
  puts @total
end

def wallet_begin
  puts "\nHow much would you like to spend at DPL Cafe?"
  user_amount = gets.to_i
  @wallet_begin = user_amount
  puts "You have $#{@wallet_begin}."
end

def wallet_end
  change = @wallet_begin - @user_main_order[0][:price] - @user_side_order[0][:price] - @user_side_order[1][:price]
  if @wallet_begin >= @total
    puts "\nYour change is: "
    puts change
    puts "Thanks for stopping by! Enjoy!"
  else @wallet_begin < @total
    puts "You do not have enough money. Please come back later."
  end
end

def menu
  options
  puts "\nPlease choose an option:"
  choice = gets.strip
  case choice
    when '1'
      main_menu
    when '2'
      wallet_begin
      main_order
      side_order
      side_order
      repeat_order
      wallet_end
    when '3'
      puts "Thanks for stopping in!"
      exit
    else
      puts "Please input a valid number."
      menu
  end
end

while
  menu
end
