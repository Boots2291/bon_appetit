require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_it_has_stock
    pantry = Pantry.new

    assert_equal ({}), pantry.stock
  end

  def test_it_can_check_for_items_in_stock
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_it_can_restock_items
    pantry = Pantry.new

    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")
  end

  def test_restock_items_adds_to_existing_items
    pantry = Pantry.new

    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 20)

    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_it_can_convert_units
    r = Recipe.new("Spicy Cheese Pizza")
    pantry = Pantry.new

    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)

    expected = {"Cayenne Pepper" => {quantity: 25, units: "Milli-Units"},
                "Cheese"         => {quantity: 75, units: "Universal Units"},
                "Flour"          => {quantity: 5, units: "Centi-Units"}}

    assert_equal expected, pantry.convert_units(r)
  end

  def test_it_can_add_to_cookbook
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    assert_instance_of Recipe, pantry.cookbook[0]
    assert_equal 3, pantry.cookbook.length
  end

  def test_it_can_check_what_it_can_make
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)
    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    expected = ["Brine Shot", "Peanuts"]

    assert_equal expected, pantry.what_can_i_make
  end

  def test_it_can_check_how_many_it_can_make
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)
    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    expected = {"Brine Shot" => 4, "Peanuts" => 2}

    assert_equal expected, pantry.how_many_can_i_make
  end

  def test_it_can_convert_mixed_units
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 1.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 550)
    pantry = Pantry.new

    expected = {"Cayenne Pepper" => [{quantity: 25, units: "Milli-Units"},
                                    {quantity: 1, units: "Universal Units"}],
                "Cheese"         => [{quantity: 75, units: "Universal Units"}],
                "Flour"          => [{quantity: 5, units: "Centi-Units"},
                                    {quantity: 50, units: "Universal Units"}]}

    assert_equal expected, pantry.convert_units(r)
  end

end
