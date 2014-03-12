class GenresController < ApplicationController

  def show
    @genres = Book.genres

    @genre = params[:id]
    @books = Book.tagged_with(@genre, on: :genres)
  end
end