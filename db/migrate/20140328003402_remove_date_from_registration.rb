class RemoveDateFromRegistration < ActiveRecord::Migration
  def change
    remove_column :registrations, :date
  end
end
