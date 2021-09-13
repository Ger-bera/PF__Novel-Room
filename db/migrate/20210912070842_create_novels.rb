class CreateNovels < ActiveRecord::Migration[5.2]
  def change
    create_table :novels do |t|
      t.integer :user_id, null: false
      t.integer :room_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :image_id
      t.timestamps
    end
  end
end
