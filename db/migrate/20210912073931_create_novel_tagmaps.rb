class CreateNovelTagmaps < ActiveRecord::Migration[5.2]
  def change
    create_table :novel_tagmaps do |t|
      t.integer :novel_id, null: false
      t.integer :novel_tag_id, null: false
      t.timestamps
    end
  end
end
