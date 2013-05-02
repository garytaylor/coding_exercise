class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.integer :bedroom_count
      t.float :latitude
      t.float :longitude
      t.datetime :rented_at

      t.timestamps
    end
    add_index :properties, :bedroom_count, :unique => false
    add_index :properties, :rented_at, :unique => false
  end
end
