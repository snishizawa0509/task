class CategoryController < ApplicationController

  def new
    @category = Category.new 
  end

  def create
    @category = Category.new
    @category.name = params[:name]
    @category.save
    if @category.save
      redirect_to @category, notice: '追加しました'
    else
      render :new
    end
  end

end
