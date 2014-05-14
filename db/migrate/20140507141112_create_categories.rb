class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :text_id, null: false
      t.string :name, null: false
    end
    add_index :categories, :text_id, unique: true
  end
end
