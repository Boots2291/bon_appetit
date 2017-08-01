require 'pry'
class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(item)
    if stock.has_key?(item)
      stock[item]
    else
      0
    end
  end

  def restock(item, quantity)
    if stock.has_key?(item)
      stock[item] + quantity
    else
      stock[item] = quantity
    end
  end

end


# pantry.restock("Cheese", 10)
# pantry.stock_check("Cheese")
# # => 10
# pantry.restock("Cheese", 20)
# pantry.stock_check("Cheese")
# # => 30