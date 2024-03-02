class AddScoreToPostSaunas < ActiveRecord::Migration[6.1]
  def change
    add_column :post_saunas, :score, :decimal, precision: 5, scale: 3
  end
end
