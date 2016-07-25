class NotesController < ApplicationController
  def new
  	@note = Note.new 
  end

  def show
    @note = Note.find(params[:id])
  end

  def index 
    @search = params[:word]
    @notes = Note.where("title like ? or content like ?",@search,@search).page(params[:page]).per(10)
    @notes = Note.page(params[:page]).per(10) if @search == nil
    #@notes = @q.result(distinct: true)
    #@q = Note.search(params[:q])
    #@notes = Note.all
  end

  def create
    @note = Note.new
    @note.title = params[:title]
    @note.content = params[:content]
    @note.category_id = params[:category_id]
    
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
end
