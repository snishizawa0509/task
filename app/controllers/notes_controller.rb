class NotesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :create, :edit]
  def new
    @note = Note.new
  end

  def show
  end

  def index
    @search_word = params[:word]
    @notes = Note.joins(:category)
    if @search_word.present?
      @search_word.split(/ |　/).each do |word|
        @notes = @notes.where('notes.title like ? or notes.content like ? or categories.name like ?', "%#{word}%", "%#{word}%", "%#{word}%")
      end
    end
    @user_key = params[:user_id]
    @notes = @notes.where('notes.user_id = ?', @user_key) if @user_key.present?
    @notes = @notes.page(params[:page]).per(10)
  end

  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      redirect_to @note, notice: '投稿されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to note_path(@note.id), notice: '投稿されました。'
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_path
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def set_categories
    @categories = Category.where(user: current_user)
  end

  def note_params
    params.require(:note).permit(:title, :content, :category_id, :image, :image_cache, :remove_image)
  end

  def correct_user
    note = Note.find(params[:id])
    redirect_to notes_path if current_user.id != note.user_id
  end
end
