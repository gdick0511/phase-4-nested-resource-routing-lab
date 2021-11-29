class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items 
    else 
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    items = Item.find(params[:id])
    render json: items, include: :user
  end

  def create 
    user = User.find(params[:user_id])
    new_item = user.items.create(items_params)
    render json: new_item, status: :created
  end

  private

  def not_found
    render json: {error: "User not found"}, status: :not_found 
  end

  def items_params
    params.permit(:name, :price, :description, :user_id)
  end

end
