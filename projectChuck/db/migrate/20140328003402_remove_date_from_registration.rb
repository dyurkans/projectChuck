class RemoveDateFromRegistration < ActiveRecord::Migration
  def up
    remove_column :registrations, :date
  end

  def down
    add_column :registrations, :date, :date
  end
end
