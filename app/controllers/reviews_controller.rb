# frozen_string_literal: true

class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @item = Item.find(params[:item_id])
  end

  def create
    review = Review.create(review_params)
    if !review.save
      redirect_to "/items/#{review.item_id}/reviews/new"
      flash[:notice] = 'Incomplete Review'
    else
      redirect_to "/items/#{review.item_id}"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)

    if !review.save
      redirect_to "/items/#{review.item_id}/#{review.id}/edit"
      flash[:notice] = 'Incomplete Review'
    else
      redirect_to "/items/#{review.item_id}"
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    @review.destroy
    redirect_to "/items/#{@review.item.id}"
  end


  private

  def review_params
    params.permit(:title, :content, :rating, :item_id)
  end
end
