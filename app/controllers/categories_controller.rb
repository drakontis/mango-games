class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      redirect_to edit_category_path(@category), :notice => 'Category has been successfully created!'
    else
      flash.now[:error] = 'Problem creating Category!'
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes!(params[:category])
      redirect_to edit_category_path(:id => @category.id), :notice => "Category has been successfully updated!"
    else
      flash.now[:error] = "Problem updating Category!"
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path, :notice => 'Category has been successfully deleted!'
    else
      flash.now[:error] = 'Problem deleting Category!'
      render :index
    end
  end
end
