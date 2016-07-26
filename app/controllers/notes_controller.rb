class NotesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
  	@note = Note.new 
  end

  def show
    @note = Note.find(params[:id])
  end
 
  def index
    @search = params[:word]
    @search_key = params[:user_id]
    @notes = Note.joins(:category).where("notes.title like ? or notes.content like ? or categories.name like ?", "%#{@search}%" , "%#{@search}%", "%#{@search}%").where("notes.user_id = ?", @search_key) if @search.present? && @search_key.present?
    @notes = Note.joins(:category).where("notes.title like ? or notes.content like ? or categories.name like ?", "%#{@search}%" , "%#{@search}%", "%#{@search}%") if @search.present? && @search_key.blank?
    @notes = Note  if @search.blank? && @search_key.blank?
    @notes = Note.where( user_id: @search_key) if @search.blank? && @search_key.present?
    @notes = @notes.page(params[:page]).per(10)
  end

  def create
    @note = Note.new
    @note.title = params[:title]
    @note.content = params[:content]
    @note.category_id = params[:category_id]
    @note.user_id = current_user.id
    if @note.save
    	redirect_to @note, notice: '投稿されました。'
  	else
			render :new 
    end
  end

  def edit
		@note = Note.find(params[:id])
  end

	def update
    @note = Note.find(params[:id])	
    @note.title = params[:title]
    @note.content = params[:content] 
    @note.category_id = params[:category_id] 
		if @note.save
      redirect_to note_path(@note.id),  notice: '投稿されました。'
    else
			render :edit 
		end
	end 

	def destroy
	  @note = Note.find(params[:id])
		@note.destroy
		redirect_to notes_path
	end

  private
    def correct_user
      note = Note.find(params[:id])
      if current_user.id != note.user_id
        redirect_to notes_path
      end
    end

end
