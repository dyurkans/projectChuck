class AddCountyToHouseholds < ActiveRecord::Migration
  def change
    add_column :households, :county, :string
  end
end
