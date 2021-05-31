# frozen_string_literal: true

require "test_helper"

class MenuItemTest < ActiveSupport::TestCase
  test "validate menu item" do
    menu_item = MenuItem.new

    assert menu_item.invalid?
    assert_equal menu_item.errors.full_messages, [
      "Name can't be blank",
      "Price can't be blank",
      "Type can't be blank",
      "Type provided not supported",
      "Price format is not valid",
    ]
  end

  test "create a menu item" do
    menu_item = MenuItem.create!(name: "First Test", price: "$5", type: :side)

    assert_equal MenuItem.count, 2
    assert_equal menu_item.name, "First Test"
  end

  test "update a menu item" do
    new_name = "New Random"
    menu_item = menu_items(:menu_item)
    assert_not_equal menu_item.name, new_name
    menu_item.update(name: new_name)
    assert_equal menu_item.name, new_name
  end

  test "delete a menu item" do
    menu_item = MenuItem.create(name: "Second Test", price: "$15", type: :main_course)

    assert menu_item.persisted?
    menu_item.delete
    assert_not menu_item.persisted?
  end

  test "fetch all menu items" do
    menu_item = MenuItem.create(name: "Third Test", price: "$15", type: :main_course)

    assert_equal MenuItem.count, 2
    assert_equal MenuItem.all.map(&:name), [menu_items(:menu_item).name, "Third Test"]
  end
end
