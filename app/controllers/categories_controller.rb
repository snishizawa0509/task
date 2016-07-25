class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update ,:destroy]
  def index
    @categories = Category.where(user: current_user) 
    @category = Category.new
  end

  def create
    @category = Category.new
    @category.name = params[:name]
    @category.user = current_user
    
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
   
  private
    def correct_user
      category = Category.find(params[:id])
      if current_user.id != category.user_id
        redirect_to categories_path
      end
    end
end
