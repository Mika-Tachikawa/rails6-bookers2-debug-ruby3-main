class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  
  #def create
    #post_image = PostImage.find(params[:post_image_id])
    #comment = current_user.post_comments.new(post_comment_params)
    #comment.post_image_id = post_image.id
    #comment.save
    #redirect_to post_image_path(post_image)
  #end
  def create
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comment.user_id = current_user.id
    unless @book_comment.save
    #redirect_to request.referer
    #リダイレクト先をjsファイルに変更
      render 'error'  # app/views/book_comments/error.js.erbを参照する ※要件外
    end
    # app/views/book_comments/create.js.erbを参照する
  end

  def destroy
    @book = Book.find(params[:book_id])
    book_comment = @book.book_comments.find(params[:id])
    book_comment.destroy
    # app/views/book_comments/destroy.js.erbを参照する
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end
