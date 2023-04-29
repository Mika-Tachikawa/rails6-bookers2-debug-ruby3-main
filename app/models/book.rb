class Book < ApplicationRecord
  
  #has_one_attachedの追記
  #has_one_attached :image
  has_one_attached :profile_image
  
  #has_many → belomgs_toの修正
  belongs_to :user
  
  #profile_imageがなかった時の表示内容の追記
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  #def get_profile_image(width, height)
    #unless profile_image.attached?
      #file_path = Rails.root.join('app/assets/images/no_image.jpg')
      #profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    #end
      #profile_image.variant(resize_to_limit: [width, height]).processed
  #end
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
