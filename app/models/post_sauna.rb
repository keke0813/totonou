class PostSauna < ApplicationRecord

  # サウナ画像
  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  #リレーション
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #バリデーション
  validates :image, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :price, presence: true
  validates :impression, presence: true
  validates :category, presence: true
end
