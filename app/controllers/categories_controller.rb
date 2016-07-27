class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update , :destroy]
  before_action :set_category, only: [:edit, :update , :destroy]
  def index
    @categories = Category.where(user: current_user) 
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params) 
    if @category.save
      redirect_to categories_path, notice: '追加しました'
    else
      redirect_to categories_path
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: '編集しました'
    else
      render :edit 
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end
   
  private 
    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:name)
    end
  
    def correct_user
      category = Category.find(params[:id])
      if current_user.id != category.user_id
        redirect_to categories_path
      end
    end
end
