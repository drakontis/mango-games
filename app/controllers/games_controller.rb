class GamesController < ApplicationController
  def index
    @games = Game.where(:approved => true).all
  end

  def new
    @game = Game.new
    @categories = Category.all
  end

  def create
    @game = Game.new(params[:game])

    if @game.save
      redirect_to game_path(@game), :notice => 'Game has been successfully created!'
    else
      @categories = Category.all
      flash.now[:error] = 'Problem creating Game!'
      render :new
    end
  end

  def show
    @game = Game.find(params[:id])
  end
end