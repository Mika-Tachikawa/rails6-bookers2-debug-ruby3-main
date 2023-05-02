class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #has_manyに
  #belongs_to :books
  #ユーザー削除と同時に投稿記事全削除＝dependent: :destroy
  has_many :books, dependent: :destroy
  has_one_attached :profile_image
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  #has manyの直後はアソシエーションが繋がっているテーブル名、class_name直後は実際のモデルの名前、foreign_keyは外部キーとして何を持つかを表しています。
  #フォローされる記述　reverse_ofは分かりやすくするために名前変えてるだけ
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #「has_many :テーブル名, through: :中間テーブル名」 の形を使って、テーブル同士が中間テーブルを通じてつながっていることを表現します。(followerテーブルとfollowedテーブルのつながりを表す）
  # 例えば、has_many直後にfollowedを入れてしまうと、followedテーブルから中間テーブルを通ってfollowerテーブルにアクセスすることができなくなってしまいます。
  # これを防ぐためにhas_many直後には架空のテーブル名を、sourceは実際にデータを取得しにいくテーブル名を書きます。
  # 自分をフォローしている人に関する、テーブルのつながり
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  #フォローする記述
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #自分がフォローしている人に関する、テーブルのつながり
  has_many :followings, through: :relationships, source: :followed

  

  #validates :title, length: { minimum: 2, maximum: 20 }, uniqueness: true
  #validates :title, length: { maximum: 20 }, uniqueness: true
  validates :name, length: { maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}
  #バリデーションの追加が不明
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
    #unless profile_image.attached?
      #file_path = Rails.root.join('app/assets/images/no_image.jpg')
      #profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    #end
    #profile_image
  end
  
  # フォローしたときの処理
  def follow(user)
    relationships.create(followed_id: user.id)
  end
# フォローを外すときの処理
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end
# フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  
end
