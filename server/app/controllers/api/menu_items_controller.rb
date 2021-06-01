# frozen_string_literal: true

module Api
  class MenuItemsController < ApplicationController
    def index
      render json: { data: MenuItem.all, errors: [] }
    end

    def show
      id = params.permit(:id)[:id]
      result = MenuItemService.find_menu_item(id)
      status = result.delete(:status)

      render status: status, json: result
    end

    def create
      data = params.permit(:name, :price, :type, :photo)

      result = MenuItemService.create_menu_item(data)
      status = result.delete(:status)

      render status: status, json: result
    end

    def update
      data = params.permit(:id, :name, :price, :type, :photo)

      result = MenuItemService.update_menu_item(data)
      status = result.delete(:status)

      render status: status, json: result
    end

    def destroy
      id = params.permit(:id)[:id]
      result = MenuItemService.delete_menu_item(id)
      status = result.delete(:status)

      render status: status, json: result
    end
  end
end
