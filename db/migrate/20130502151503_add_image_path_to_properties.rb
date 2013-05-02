class AddImagePathToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :image_path, :string
    Property.all.each_with_index do |property,index|
      property.update_attribute :image_path, "/assets/example_data/flat#{(index%5)+1}.jpg"
    end
  end
end
