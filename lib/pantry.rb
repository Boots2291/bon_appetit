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