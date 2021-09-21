class RemoveNovelIdFromNovelTags < ActiveRecord::Migration[5.2]
  def change
    remove_column :novel_tags, :novel_id, :integer
  end
end
