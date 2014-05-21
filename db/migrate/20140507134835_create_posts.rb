class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :category, null: false, index: true
      t.belongs_to :author, null: false, index: true
      t.string :title, null: false
      t.text :content, null: false
      t.text :parsed_content, null: false
      t.text :parsed_excerpt, default: nil
      t.datetime :created_at, null: false
    end
  end
end
