# frozen_string_literal: true

require "test_helper"

class MenuTest < ActiveSupport::TestCase
  PRESENCE_ERRORS = [
    "Name can't be blank",
    "Price can't be blank",
    "Type can't be blank",
  ]

  test "validate presence of menu item fields" do
    menu = Menu.new

    assert menu.invalid?
    assert_equal menu.errors.full_messages, PRESENCE_ERRORS
  end

  test "create a menu item" do
    menu = Menu.create(name: "Test #1", price: "$5", type: :side)

    assert_equal Menu.count, 2
    assert_equal menu.name, "Test #1"
  end

  test "update a menu item" do
    menu = menus(:menu)

    assert menu.main_course?
    menu.side!
    assert menu.side?
  end

  test "delete a menu item" do
    menu = Menu.create(name: "Test #2", price: "$15", type: :main_course)

    assert menu.persisted?
    menu.delete
    assert_not menu.persisted?
  end

  test "fetch all menu items" do
    menu = Menu.create(name: "Test #3", price: "$15", type: :main_course)

    assert_equal Menu.count, 2
    assert_equal Menu.all.map(&:name), [menus(:menu).name, "Test #3"]
  end
end
