class CreateRoomFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :room_favorites do |t|
      t.integer :room_id, null: false
      t.integer :user_id, null: false
      
      t.timestamps
    end
  end
end
