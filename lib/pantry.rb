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
          convert_to_centi(amount, converted)
        elsif amount > 1 && (amount % 100).class == Float
          decimal = amount % 1
          integer = amount.to_i
          convert_to_centi(decimal, converted)
          return_universal_units(integer, converted)
        elsif amount < 1
          convert_to_milli(amount, converted)
        else
          return_universal_units(amount, converted)
        end
      recipe.ingredients[item] = converted
    end
  end

  def convert_to_centi(amount, converted)
    converted[:quantity] = (amount / 100).to_i
    converted[:units] = "Centi-Units"
  end

  def convert_to_milli(amount, converted)
    converted[:quantity] = (amount * 1000).to_i
    converted[:units] = "Milli-Units"
  end

  def return_universal_units(amount, converted)
    converted[:quantity] = amount
    converted[:units] = "Universal Units"
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
      compare_ingredients_to_quantities(recipe, can_make)
    end
    can_make
  end

  def compare_ingredients_to_quantities(recipe, can_make)
    recipe.ingredients.each do |item, quantity|
      if stock.has_key?(item) && stock[item] > quantity
        can_make[recipe.name] = stock[item] / quantity
      end
    end
  end

end