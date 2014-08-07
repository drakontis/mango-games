class RanksController < ApplicationController
  def index
    @ranks = Rank.all
  end

  def new
    @rank = Rank.new
  end

  def create
    @rank = Rank.new(params[:rank])

    privileges = params[:rank_privileges]

    privileges.each do |p|
      p = p.split('/')
      @rank.rank_privileges << RankPrivilege.new(:model => p.first, :action => p.last)
    end unless privileges.nil?

    if @rank.save
      redirect_to edit_rank_path(@rank), :notice => "Rank has been successfully created!"
    else
      flash.now[:error] = "Problem creating Rank!"
      prepare_render
      render :new
    end
  end

  def edit
    prepare_render
    @rank = Rank.find(params[:id])
  end

  def update
    @rank = Rank.find(params[:id])

    # Get privileges attributes
    privileges = params[:rank_privileges]

    # Get rank attributes
    rank_attributes = params[:rank] || {}

    # Prepare privileges for rank
    new_privileges = []
    privileges.each do |p|
      p = p.split('/')
      new_privileges << {:model => p.first, :action => p.last}
    end unless privileges.nil?

    existing_privileges = []
    @rank.rank_privileges.each do |r|
      if new_privileges.include?({:model => r.model, :action => r.action})
        new_privileges.delete_if{|p| p[:model] == r.model && p[:action] == r.action}
      else
        existing_privileges << {:id => r.id, :_destroy => '1'}
      end
    end

    rank_privileges_attributes = {:rank_privileges_attributes => existing_privileges + new_privileges}

    # Merge rank and privileges attributes
    rank_attributes.merge!(rank_privileges_attributes) unless rank_privileges_attributes.nil?

    # Save rank
    if @rank.update_attributes!(rank_attributes)
      redirect_to edit_rank_path(@rank), :notice => "Rank has been successfully updated!"
    else
      prepare_render
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

  #########
  protected
  #########

  def prepare_render
    @privileges = Privilege.all
  end
end