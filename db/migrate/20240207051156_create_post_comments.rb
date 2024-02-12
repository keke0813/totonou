class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|

      #追加カラム
      t.integer :user_id, null: false
      t.integer :post_sauna_id, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
