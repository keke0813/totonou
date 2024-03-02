# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者のシードデータ
Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

#ユーザー作成
olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.introduction = "よろしくお願いします"
  user.favorite_drink = "水"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
  user.favorite_drink_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-drink1.jpg"), filename:"sample-drink1.jpg")
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.introduction = "よろしく!!"
  user.favorite_drink = "スポーツドリンク"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
  user.favorite_drink_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-drink2.jpg"), filename:"sample-drink2.jpg")
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.introduction = "お願いいたします!!"
  user.favorite_drink = "お茶"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
  user.favorite_drink_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-drink3.jpg"), filename:"sample-drink3.jpg")
end

#投稿作成
PostSauna.find_or_create_by!(name: "蒸気の楽園") do |post_sauna|
  post_sauna.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post_sauna.address = "フェイク都架空区虚構町4-5-6"
  post_sauna.price = "1000"
  post_sauna.impression = "大人気のサウナです。"
  post_sauna.category = "ドライサウナ"
  post_sauna.star = 3
  post_sauna.user = olivia
  post_sauna.score = Language.get_data(post_sauna.impression)
end

PostSauna.find_or_create_by!(name: "温泉サファリ") do |post_sauna|
  post_sauna.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post_sauna.address = "シミュレート県アドベンチャー市冒険町7-8-9"
  post_sauna.price = "800"
  post_sauna.impression = "整えました。"
  post_sauna.category = "ミストサウナ"
  post_sauna.star = 2
  post_sauna.user = james
  post_sauna.score = Language.get_data(post_sauna.impression)
end

PostSauna.find_or_create_by!(name: "スチーム・オアシス") do |post_sauna|
  post_sauna.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post_sauna.address = "ビジョン県イマジン市幻想町13-14-15"
  post_sauna.price = "1200"
  post_sauna.impression = "外気浴が素晴らしい。"
  post_sauna.category = "塩サウナ"
  post_sauna.star = 5
  post_sauna.user = lucas
  post_sauna.score = Language.get_data(post_sauna.impression)
end

#コメント作成
PostComment.find_or_create_by!(post_sauna: PostSauna.find_by(name: "蒸気の楽園")) do |post_comment|
  post_comment.user = james
  post_comment.comment = "素敵なサウナ体験ですね!"
  post_comment.score = Language.get_data(post_comment.comment)
end
PostComment.find_or_create_by!(post_sauna: PostSauna.find_by(name: "温泉サファリ")) do |post_comment|
  post_comment.user = lucas
  post_comment.comment = "この施設はきれいでしたか？"
  post_comment.score = Language.get_data(post_comment.comment)
end
PostComment.find_or_create_by!(post_sauna: PostSauna.find_by(name: "スチーム・オアシス")) do |post_comment|
  post_comment.user = olivia
  post_comment.comment = "最高のリラックス感があります！"
  post_comment.score = Language.get_data(post_comment.comment)
end


# いいね作成
Favorite.find_or_create_by!(user: olivia, post_sauna: PostSauna.find_by(name: "蒸気の楽園"))
Favorite.find_or_create_by!(user: james, post_sauna: PostSauna.find_by(name: "温泉サファリ"))
Favorite.find_or_create_by!(user: lucas, post_sauna: PostSauna.find_by(name: "スチーム・オアシス"))

# フォロー・フォロワー関係作成
olivia.follow(james)
lucas.follow(james)
james.follow(olivia)
