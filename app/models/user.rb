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

  #validates :title, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :title, length: { maximum: 20 }, uniqueness: true
  #バリデーションの追加が
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
    #unless profile_image.attached?
      #file_path = Rails.root.join('app/assets/images/no_image.jpg')
      #profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    #end
    #profile_image
  end
end
