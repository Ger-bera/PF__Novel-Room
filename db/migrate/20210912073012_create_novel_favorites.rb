class CreateNovelFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :novel_favorites do |t|
      t.integer :novel_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
