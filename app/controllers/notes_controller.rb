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
    @search_word = params[:word]
    @notes = Note.joins(:category) 
    if @search_word.present?
        for word in @search_word.split(/ |　/)
        @notes = @notes.where("notes.title like ? or notes.content like ? or categories.name like ?", "%#{word}%" , "%#{word}%", "%#{word}%")
      end
    end
    @user_key = params[:user_id]
    @notes = @notes.where("notes.user_id = ?", @user_key) if @user_key.present?
    @notes = @notes.page(params[:page]).per(10)
  end

  def create
    @note = Note.new
    @note.title = params[:title]
    @note.content = params[:content]
    @note.category_id = params[:category_id]
    @note.user_id = current_user.id
     
    file = params[:image]
    @note.image = params[:image] if file.present?
    
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
	
    @check = params[:check]
    @note.remove_image! if @check == "true"
    file = params[:image]
    @note.image = params[:image] if file.present?

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
