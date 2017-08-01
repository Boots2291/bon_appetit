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

  

  ### Iteration 2: Unit Conversions
# So far our Pantry and Recipes have used a 1-tier unit scale -- the tried-and-true
# UNIVERSAL UNIT. But this becomes somewhat cumbersome for a busy chef in their kitchen.
# No one wants to try to measure out .0001 Universal Units.
# Let's add a feature to our Pantry tracker that lets us output recipes with more r
# eadable unit conversions thrown in.
# We'll introduce these units:
# * Centi-Units -- Equals 100 Universal Units
# * Milli-Units -- Equals 1/1000 Universal Units
# Then, we'll add a new method, `convert_units`, which takes a `Recipe` and outputs
# updated units for it following these rules:
# 1. If the recipe calls for more than 100 Units of an ingredient, convert it to
# Centi-units
# 2. If the recipe calls for less than 1 Units of an ingredient, convert it to
# Milli-units
# Follow this interaction pattern:
# ```ruby
# # Building our recipe
# r = Recipe.new("Spicy Cheese Pizza")
# r.add_ingredient("Cayenne Pepper", 0.025)
# r.add_ingredient("Cheese", 75)
# r.add_ingredient("Flour", 500)
# pantry = Pantry.new
# # Convert units for this recipe
# pantry.convert_units(r)
# => {"Cayenne Pepper" => {quantity: 25, units: "Milli-Units"},
#     "Cheese"         => {quantity: 75, units: "Universal Units"},
#     "Flour"          => {quantity: 5, units: "Centi-Units"}}
# ```
