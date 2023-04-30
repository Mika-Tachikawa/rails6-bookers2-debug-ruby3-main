class BookCommentsController < ApplicationController
  
  #def create
    #post_image = PostImage.find(params[:post_image_id])
    #comment = current_user.post_comments.new(post_comment_params)
    #comment.post_image_id = post_image.id
    #comment.save
    #redirect_to post_image_path(post_image)
  #end
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end
