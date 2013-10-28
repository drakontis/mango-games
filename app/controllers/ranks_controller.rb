class RanksController < ApplicationController
  def index
    @ranks = Rank.all
  end

  def new
    @rank = Rank.new
  end

  def create
    @rank = Rank.new(params[:rank])

    if @rank.save
      redirect_to edit_rank_path(@rank), :notice => "Rank has been successfully created!"
    else
      flash.now[:error] = "Problem creating Rank!"
      render :new
    end
  end

  def edit
    @rank = Rank.find(params[:id])
  end

  def update
    @rank = Rank.find(params[:id])
    if @rank.update_attributes!(params[:rank])
      redirect_to edit_ranks_path(:id => @rank.id), :notice => "Rank has been successfully updated!"
    else
      flash.now[:error] = "Problem updating Rank!"
      render :edit
    end
  end

  def destroy
    @rank = Rank.find(params[:id])
    if @rank.destroy
      redirect_to ranks_path, :notice => 'Rank has been successfully deleted!'
    else
      flash.now[:error] = 'Problem deleting Rank!'
      render :index
    end
  end
end