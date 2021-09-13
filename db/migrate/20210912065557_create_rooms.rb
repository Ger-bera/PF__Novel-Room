class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :user_id, null: false
      t.string :room_name, null: false
      t.text :world_body, null: false
      
      t.timestamps
    end
  end
end
