class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    @merchant = Merchant.create(merchant_params)

    if !@merchant.save
      redirect_to "/merchants/new"
      flash[:notice] = 'Complete all merchant details to continue'
    else
      redirect_to '/merchants'
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)

    if !@merchant.save
      redirect_to "/merchants/#{@merchant.id}/edit"
      flash[:notice] = 'Complete all merchant details to continue'
    else
      redirect_to "/merchants/#{@merchant.id}"
    end
  end

  def destroy
    Merchant.destroy(params[:id])
    redirect_to '/merchants'
  end

  private

  def merchant_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
