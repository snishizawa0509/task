class CategoriesController < ApplicationController

  def index
    @categories = Category.all 
    @category = Category.new
  end

  def create
    @category = Category.new
    @category.name = params[:name]
    if @category.save
      redirect_to categories_path, notice: '追加しました'
    else
      redirect_to categories_path
    end
  end

  def edit
    @category = Category.find(params[:id])

  end

  def update
    @category = Category.find(params[:id])
    @category.name = params[:name]
    if @category.save
      redirect_to categories_path, notice: '編集しました'
    else
      render :edit 
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end
end
