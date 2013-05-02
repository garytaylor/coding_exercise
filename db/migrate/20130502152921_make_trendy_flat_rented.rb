class MakeTrendyFlatRented < ActiveRecord::Migration
  def up
    Property.find_by_name("Trendy flat").update_attribute :rented_at, Time.now
  end

  def down
  end
end
