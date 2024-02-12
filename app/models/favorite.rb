class Favorite < ApplicationRecord

  #リレーション
  belongs_to :user
  belongs_to :post_sauna

  #バリデーション
  validates :user_id, uniqueness: {scope: :post_sauna_id}

end
