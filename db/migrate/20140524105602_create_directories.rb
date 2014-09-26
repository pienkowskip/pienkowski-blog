class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.string :ancestry, index: true
      t.text :fullpath, null: false, index: true
      t.string :name, null: false
    end
    add_index :directories, [:name, :ancestry], unique: true
  end
end
