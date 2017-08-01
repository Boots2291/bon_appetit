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
      recipe.ingredients.each do |item, quantity|
        if stock.has_key?(item) && stock[item] > quantity
          can_make << recipe.name
        end
      end
    end
    can_make.uniq
  end

end

# pantry = Pantry.new
# # Building our recipe
# r1 = Recipe.new("Cheese Pizza")
# r1.add_ingredient("Cheese", 20)
# r1.add_ingredient("Flour", 20)
# r2 = Recipe.new("Brine Shot")
# r2.add_ingredient("Brine", 10)
# r3 = Recipe.new("Peanuts")
# r3.add_ingredient("Raw nuts", 10)
# r3.add_ingredient("Salt", 10)
# # Adding the recipe to the cookbook
# pantry.add_to_cookbook(r1)
# pantry.add_to_cookbook(r2)
# pantry.add_to_cookbook(r3)
# # Stock some ingredients
# pantry.restock("Cheese", 10)
# pantry.restock("Flour", 20)
# pantry.restock("Brine", 40)
# pantry.restock("Raw nuts", 20)
# pantry.restock("Salt", 20)
# # What can i make?
# pantry.what_can_i_make # => ["Brine Shot", "Peanuts"]
# # How many can i make?
# pantry.how_many_can_i_make # => {"Brine Shot" => 4, "Peanuts" => 2}
