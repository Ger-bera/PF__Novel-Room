class RemoveRoomIdFromRoomTags < ActiveRecord::Migration[5.2]
  def change
    remove_column :room_tags, :room_id, :integer
  end
end
