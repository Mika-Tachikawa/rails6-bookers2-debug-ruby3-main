class UsersController < ApplicationController
  
  before_action :authenticate_user!
  #before_action :ensure_correct_user, only: [:update] から修正  
  before_action :ensure_correct_user, only: [:edit, :update]


  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  #endの追記
  end

  def edit
    #インスタンス変数追記
    @user = User.find(params[:id]) 
  end

  def update
    #インスタンス変数追記
    @user = User.find(params[:id])
    if @user.update(user_params)
      #リダイレクト先修正　users_path(@user)から
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #def ensure_correct_user から修正
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
end
