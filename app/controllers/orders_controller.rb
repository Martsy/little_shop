# frozen_string_literal: true

class OrdersController < ApplicationController
  def new
    @order = Order.new
    @items = Item.find(cart.item_and_quantity)
  end

  def create
    @items = Item.find(cart.item_and_quantity)
    @order = Order.new(order_params)
    cart.item_and_quantity.each do |item, _quantity|
      OrderItem.create(price: Item.find(item).price, quantity: cart.count_of(item), order: @order, item_id: item)
    end

    if !@order.save
      redirect_to '/orders/new'
      flash[:notice] = 'Incomplete Address'
    else
      redirect_to "/orders/#{@order.id}"
    end
  end

  def show
    @items = Item.find(cart.item_and_quantity)
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
