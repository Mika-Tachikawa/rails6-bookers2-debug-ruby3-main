class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    #post_image = PostImage.find(params[:post_image_id])
    #favorite = current_user.favorites.new(post_image_id: post_image.id)
    #favorite.save
    #redirect_to post_image_path(post_image)
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
    #リダイレクト先を削除
    #redirect_to request.referer
  end

  def destroy
    #post_image = PostImage.find(params[:post_image_id])
    #favorite = current_user.favorites.find_by(post_image_id: post_image.id)
    #favorite.destroy
    #redirect_to post_image_path(post_image)
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    #リダイレクト先を削除
    #redirect_to request.referer
  end
  
end
