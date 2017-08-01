class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(item)
    if stock.has_key?(item)
      item.value
    else
      0
    end
  end

  

end


# pantry.restock("Cheese", 10)
# pantry.stock_check("Cheese")
# # => 10
# pantry.restock("Cheese", 20)
# pantry.stock_check("Cheese")
# # => 30