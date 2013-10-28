class GamesController < ApplicationController
  def index
    @games = Game.all
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
      render :new, :alert => 'Problem creating game!'
    end
  end

  def show
    @game = Game.find(params[:id])
  end
end