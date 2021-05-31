# frozen_string_literal: true

module Api
  class MenuItemsController < ApplicationController
    def index
      render json: { data: MenuItem.all }
    end

    def show
      result = MenuItemService.call(action: :find, id: params[:id])
      status = result.delete(:status)

      render status: status, json: result
    end

    def create
      result = MenuItemService.call(action: :create, **permitted_params)
      status = result.delete(:status)

      render status: status, json: result
    end

    def update
      result = MenuItemService.call(action: :update, id: params[:id], **permitted_params)
      status = result.delete(:status)

      render status: status, json: result
    end

    def destroy
      result = MenuItemService.call(action: :delete, id: params[:id])
      status = result.delete(:status)

      render status: status, json: result
    end

    private

    def permitted_params
      params.require(:menu_item).permit(:name, :price, :type)
    end
  end
end
