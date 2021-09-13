class CreateRoomTagmaps < ActiveRecord::Migration[5.2]
  def change
    create_table :room_tagmaps do |t|
      t.integer :room_id, null: false
      t.integer :room_tag_id, null: false
      t.timestamps
    end
  end
end
