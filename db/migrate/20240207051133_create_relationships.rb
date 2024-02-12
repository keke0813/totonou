class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|

      #追加カラム
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false

      t.timestamps
    end
  end
end
