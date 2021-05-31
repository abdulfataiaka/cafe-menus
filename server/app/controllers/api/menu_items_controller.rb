# frozen_string_literal: true

module Api
  class MenuItemsController < ApplicationController
    def index
      render json: { data: MenuItem.all }
    end

    def show
      result = MenuItemService.create(**permitted_params).find_menu_item

      render json: result
    end

    def create
      result = MenuItemService.create(**permitted_params).create_menu_item
      status = result[:errors].any? ? :bad_request : :created

      render status: status, json: result
    end

    def update
      result = MenuItemService.create(**permitted_params).update_menu_item
      status = result[:errors].any? ? :bad_request : :ok

      render status: status, json: result
    end

    def destroy
      result = MenuItemService.create(**permitted_params).delete_menu_item

      render json: result
    end

    private

    def permitted_params
      params.permit(:id, :name, :price, :type, :photo)
    end
  end
end
