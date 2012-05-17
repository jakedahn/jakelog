class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :raw_body
      t.text :cached_body
      t.integer :current_version

      t.timestamps
    end
  end
end
