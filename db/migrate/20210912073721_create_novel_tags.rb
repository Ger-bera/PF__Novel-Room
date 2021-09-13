class CreateNovelTags < ActiveRecord::Migration[5.2]
  def change
    create_table :novel_tags do |t|
      t.integer :novel_id, null: false
      t.string :tag_name, null: false
      t.timestamps
    end
  end
end
