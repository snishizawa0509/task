class NotesController < ApplicationController


  def new
   
  end

  def create
    @note = Note.new
    @note.title = params[:title]
    @note.content = params[:content]
    @note.save
    redirect_to notes_new_path(@note.id)
  end

end


