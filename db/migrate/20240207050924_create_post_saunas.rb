class CreatePostSaunas < ActiveRecord::Migration[6.1]
  def change
    create_table :post_saunas do |t|

      #追加カラム
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.integer :price, null: false
      t.text :impression, null: false
      t.string :category, null: false
      t.string :star, null: false
      t.timestamps
    end
  end
end
