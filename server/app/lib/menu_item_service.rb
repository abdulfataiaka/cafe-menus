# frozen_string_literal: true

class MenuItemService < Service
  def call
    return update_menu_item if @action == :update
    return delete_menu_item if @action == :delete
    return find_menu_item if @action == :find
    create_menu_item
  end

  private

  def find_menu_item
    menu_item = MenuItem.find_by(id: @id)

    { status: :ok, data: menu_item, errors: [] }.tap do |result|
      if menu_item.nil?
        result[:status] = :not_found
        result[:errors] << "Menu item with id `#{@id}` not found"
      end
    end
  end

  def create_menu_item
    menu_item = MenuItem.create(**params)
    errors = build_errors(menu_item)

    { status: :created, data: menu_item, errors: errors }.tap do |result|
      unless errors.empty?
        result[:data] = nil
        result[:status] = :bad_request
      end
    end
  end

  def update_menu_item
    result = find_menu_item

    return result unless result[:errors].empty?

    menu_item = result[:data]
    menu_item.update(**params)
    errors = build_errors(menu_item)

    { status: :ok, data: menu_item, errors: errors }.tap do |result|
      unless errors.empty?
        result[:data] = nil
        result[:status] = :bad_request
      end
    end
  end

  def delete_menu_item
    result = find_menu_item

    return { status: :bad_request, data: false, errors: result[:errors] } unless result[:errors].empty?

    result[:data].destroy

    { status: :ok, data: true, errors: [] }
  end

  def params
    { name: @name, price: @price, type: @type }.compact
  end

  def build_errors(record)
    record.errors.map do |error|
      subject = error.attribute.to_s.titleize
      messages = error.message

      if messages.is_a?(Array)
        messages.map { |message| "#{subject} #{message}" }
      else
        "#{subject} #{messages}"
      end
    end.flatten
  end
end
