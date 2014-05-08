class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :text_id
      t.string :name
    end
  end
end
