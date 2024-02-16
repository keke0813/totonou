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

  # 絞り込み機能
  def self.search(search, word)
    if search == "perfect_match"
      @post_sauna = PostSauna.where(name: "#{word}")
    elsif search == "partial_match"
      @post_sauna = PostSauna.where("name LIKE?", "%#{word}%")
    else
      @post_sauna = PostSauna.all
    end
  end

  # いいねをつけた投稿の取得
  def self.liked_post_saunas(user)           # 1. モデル内での操作を開始
    includes(:favorites)                           # 2. post_favorites テーブルを結合
      .where(favorites: {user_id: user.id})        # 3. ユーザーがいいねしたレコードを絞り込み
      .order(created_at: :desc)                    # 4. 投稿を作成日時の降順でソート
  end

  #バリデーション
  validates :image, presence: true
  validates :name, length: { in: 1..50 }
  validates :address, length: { in: 1..100 }
  validates :price, length: { in: 1..10 }, numericality: true
  validates :impression, length: { in: 1..200 }
  validates :category, length: { in: 1..50 }
end
