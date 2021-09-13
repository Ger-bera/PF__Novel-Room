class CreateRoomTags < ActiveRecord::Migration[5.2]
  def change
    create_table :room_tags do |t|
      t.integer :room_id, null: false
      t.string :tag_name, null: false
      t.timestamps
    end
  end
end
