# frozen_string_literal: true

class MenuItemServiceTest < ActiveSupport::TestCase
  test "create menu item" do
    result = MenuItemService.create(name: "Test #1", type: "side", price: "$56").create_menu_item

    assert_equal MenuItem.count, 2
    assert_equal result[:data].name, "Test #1"
  end

  test "create menu item with errors" do
    result = MenuItemService.create(name: "Test #2", type: "bad_type", price: "$567").create_menu_item

    assert_equal MenuItem.count, 1
    assert_equal result[:errors], ["Type provided not supported"]
  end

  test "update menu item" do
    menu_item = menu_items(:menu_item)
    new_name = "Test #2"
    assert_not_equal menu_item.name, new_name

    result = MenuItemService.create(id: menu_item.id, name: new_name).update_menu_item

    assert_equal MenuItem.count, 1
    assert_equal result[:data].name, new_name
  end

  test "find menu item" do
    menu_item = menu_items(:menu_item)
    result = MenuItemService.create(id: menu_item.id).find_menu_item
    assert_equal menu_item.id, result[:data].id
  end

  test "delete menu item" do
    menu_item = menu_items(:menu_item)
    assert MenuItem.count, 1
    result = MenuItemService.create(id: menu_item.id).delete_menu_item
    assert MenuItem.count, 0
  end
end
