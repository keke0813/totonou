class PostComment < ApplicationRecord

  #リレーション
  belongs_to :user
  belongs_to :post_sauna

end
