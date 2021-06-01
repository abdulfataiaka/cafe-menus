# frozen_string_literal: true

require 'test_helper'

class MenuItemTest < ActiveSupport::TestCase
  test 'validate menu item' do
    menu_item = MenuItem.new

    assert menu_item.invalid?
    assert_equal menu_item.errors.full_messages, [
      "Name can't be blank",
      "Type can't be blank",
      "Type provided not supported",
      "Price can't be blank",
      "Price format is not valid",
    ]
  end

  test 'transform menu item name' do
    menu_item = MenuItem.create!(name: 'TesT NaMe', price: '$5', type: :side)

    assert_equal MenuItem.count, 2
    assert_equal menu_item.name, 'Test Name'
  end
end
