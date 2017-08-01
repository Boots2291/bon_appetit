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
      stock[item] += quantity
    else
      stock[item] = quantity
    end
  end

  def convert_units(recipe)
    recipe.ingredients.each do |item, amount|
      converted = {}
      if amount > 100
        converted[:quantity] = (amount / 100).to_i
        converted[:units] = "Centi-Units"
      elsif amount < 1
        converted[:quantity] = (amount * 1000).to_i
        converted[:units] = "Milli-Units"
      else
        converted[:quantity] = amount
        converted[:units] = "Universal Units"
      end
      recipe.ingredients[item] = converted
    end
  end

end
