class PostComment < ApplicationRecord

  #リレーション
  belongs_to :user
  belongs_to :post_sauna

  #バリデーション
  validates :comment, length: { in: 1..50 }

end
