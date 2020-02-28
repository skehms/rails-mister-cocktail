require 'open-uri'

class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end



  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.destroy

    redirect_to cocktails_path
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    @cocktail.update
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
    @dose = Dose.new
    @pic = get_json
  end

  def new
    @cocktail = Cocktail.new
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.save

    redirect_to edit_cocktail_path(@cocktail)
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end

  def get_json
    @name = @cocktail.name.downcase
    @name.gsub!(" ", "%20")
    source = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
    loaded = open(source + @name).read
    @data = JSON.parse(loaded)
    if @data['drinks']
      first_pic = @data['drinks'][0]
      if first_pic
        @pic = @data['drinks'][0]['strDrinkThumb']
      end
      else
        @pic = 'https://static.vinepair.com/wp-content/uploads/2017/11/sidecar-inside.jpg'
    end
  end
end
