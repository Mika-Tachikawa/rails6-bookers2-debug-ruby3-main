Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #一番上の行へ移動
  devise_for :users

  #root :to =>"homes#top"から修正
  root to: 'homes#top'
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
   #１投稿に１回しかいいねしないので、削除の際はユーザーidとbookのidがわかればいい
   #なので、単数系にして、いいねの/:idがurlに含まれなくなってもよい
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  
  # ネストさせる
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  #検索ボタンが押された時、Searchesコントローラーのsearchアクションが実行される
  get "search" => "searches#search"
  


#endの追記
end
