# frozen_string_literal: true

class MenuItemServiceTest < ActiveSupport::TestCase
  test 'create menu item' do
    data = { name: 'Test #1', type: 'side', price: '$56' }
    result = MenuItemService.create_menu_item(data)

    assert_equal MenuItem.count, 2
    assert_equal result[:status], :created
    assert_equal result[:data].name, data[:name]
  end

  test 'update menu item' do
    menu_item = menu_items(:menu_item)
    data = { id: menu_item.id, name: 'New Name' }

    assert_not_equal menu_item.name, data[:name]
    result = MenuItemService.update_menu_item(data)
    assert_equal menu_item.reload.name, data[:name]
  end

  test 'find menu item' do
    menu_item = menu_items(:menu_item)
    result = MenuItemService.find_menu_item(menu_item.id)
    assert_equal menu_item.id, result[:data].id
  end

  test 'delete menu item' do
    menu_item = menu_items(:menu_item)
    assert_equal MenuItem.count, 1
    result = MenuItemService.delete_menu_item(menu_item.id)
    assert_equal MenuItem.count, 0
  end
end
