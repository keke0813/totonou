class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #プロフィール画像
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  #ドリンク画像
  has_one_attached :favorite_drink_image

  def get_favorite_drink_image(width, height)
    unless favorite_drink_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      favorite_drink_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    favorite_drink_image.variant(resize_to_limit: [width, height]).processed
  end


  #リレーション
  has_many :post_saunas, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy  # フォローしている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy  # フォローされている関連付け
  has_many :followings, through: :active_relationships, source: :followed # フォローしているユーザーを取得
  has_many :followers, through: :passive_relationships, source: :follower # フォロワーを取得

  # 指定したユーザーをフォローする
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  # 指定したユーザーのフォローを解除する
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
  # 指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followings.include?(user)
  end

  # 絞り込み機能
  def self.search(search, word)
    if search == "perfect_match"
      @user = User.where(name: "#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?", "%#{word}%")
    else
      @user = User.all
    end
  end

  #ゲストユーザーメソッド
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.introduction = "guestuser_introduction"
      user.favorite_drink = "guestuser_favorite_drink"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  #ユーザーステータス管理
  def user_status
    if is_active == true
      "有効"
    else
      "利用停止"
    end
  end

  def active_for_authentication?
    super && (is_active == true)
  end

  #バリデーション
  validates :name,  length: { in: 1..50 }
  validates :introduction, length: { in: 1..100 }
  validates :favorite_drink, length: { in: 1..50 }
end
