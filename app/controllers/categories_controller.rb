class CategoriesController < ApplicationController

  def index
    @categories = Category.all 
    @category = Category.new
  end

  def create
    @category = Category.new
    @category.name = params[:name]
    @category.save
    if @category.save
      redirect_to categories_path, notice: '追加しました'
    else
      redirect_to categories_path
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end
end
