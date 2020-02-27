class CocktailsController < ApplicationController
  # before_action :set_cocktail, only: [:show, :destroy]
  def index
    @cocktails = Cocktail.all
  end

  def new
    @cocktail = Cocktail.new
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def create
    @cocktail = Cocktail.new(params_cocktail)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktails.destroy
    redirect_to cocktail_path(@cocktail)
  end

  def params_cocktail
    params.require(:cocktail).permit(:name, :photo)
  end
end
