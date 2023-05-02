class RelationshipController < ApplicationController

 #特定のアクションを実行する前に、ユーザーの認証が必要であることを示すメソッド
 #before_actionは、指定したアクションが実行される前に、事前に実行されるメソッドを指定するためのメソッド
 #authenticate_user!は、DeviseというGemが提供するメソッド
 #before_action :authenticate_user!をコントローラー内で宣言することで、
 #そのコントローラー内で定義されたアクションが実行される前に、ユーザーの認証が自動的に行われるようになる
 #ユーザーがログインしていない場合は、ログインページにリダイレクト
  before_action :authenticate_user!
  
 #フォローするとき
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
		redirect_to request.referer
  end
  
 #フォロー解除するとき
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
		redirect_to request.referer
  end
  
    # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  
    # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  
  
end
