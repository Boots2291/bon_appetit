require 'pry'
class Pantry
  attr_reader :stock,
              :cookbook

  def initialize
    @stock = {}
    @cookbook = []
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

  def add_to_cookbook(recipe)
    cookbook << recipe
  end

  def what_can_i_make
    can_make = []
    cookbook.each do |recipe|
      compare_ingredients(recipe, can_make)
    end
    can_make.uniq
  end

  def compare_ingredients(recipe, can_make)
    recipe.ingredients.each do |item, quantity|
      if stock.has_key?(item) && stock[item] > quantity
        can_make << recipe.name
      end
    end
  end

  def how_many_can_i_make
    can_make = {}
    cookbook.each do |recipe|
      recipe.ingredients.each do |item, quantity|
        if stock.has_key?(item) && stock[item] > quantity
          can_make[recipe.name] = stock[item] / quantity
        end
      end
    end
    can_make
  end

end

# Building our recipe
# r = Recipe.new("Spicy Cheese Pizza")
# r.add_ingredient("Cayenne Pepper", 1.025)
# r.add_ingredient("Cheese", 75)
# r.add_ingredient("Flour", 550)
# pantry = Pantry.new
# # Convert units for this recipe
# pantry.convert_units(r)
# => {"Cayenne Pepper" => [{quantity: 25, units: "Milli-Units"},
#                          {quantity: 1, units: "Universal Units"}],
#     "Cheese"         => [{quantity: 75, units: "Universal Units"}],
#     "Flour"          => [{quantity: 5, units: "Centi-Units"},
#                          {quantity: 50, units: "Universal Units"}]}