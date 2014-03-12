class AddDefaultsToBooleans < ActiveRecord::Migration
  def change
  	change_column :users, :active, :boolean, :default => true
  	change_column :guardians, :active, :boolean, :default => true
  	change_column :guardians, :receive_texts, :boolean, :default => true
  	change_column :households, :active, :boolean, :default => true
  	change_column :students, :active, :boolean, :default => true
  	change_column :registrations, :active, :boolean, :default => true
  end
end
