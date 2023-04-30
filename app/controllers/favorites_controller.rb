class FavoritesController < ApplicationController
  
  def create
    #post_image = PostImage.find(params[:post_image_id])
    #favorite = current_user.favorites.new(post_image_id: post_image.id)
    #favorite.save
    #redirect_to post_image_path(post_image)
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    redirect_to book_path(book)
  end

  def destroy
    #post_image = PostImage.find(params[:post_image_id])
    #favorite = current_user.favorites.find_by(post_image_id: post_image.id)
    #favorite.destroy
    #redirect_to post_image_path(post_image)
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to book_path(book)
  end
  
end