class MenuItemController < ApplicationController
  # Get all items from a particular restaurant
  def items_by_restaurant
    restaurant = Restaurant.find_by(id: params[:restaurant_id])
    if restaurant.nil?
      render :json => { error: "Restaurant not found" }, status: 401
      return
    end
    menu_items = MenuItem.where(restaurant_id: restaurant.id)

    render :json => { menu_items: menu_items }, status: 200
  end
end