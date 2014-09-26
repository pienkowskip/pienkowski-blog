class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.belongs_to :directory, null: false
      t.string :name, null: false
      t.string :type, null: false
      t.string :title
      t.datetime :created_at, null: false
      t.binary :content, null: false
    end
  end
end
