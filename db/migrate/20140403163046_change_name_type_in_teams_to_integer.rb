class ChangeNameTypeInTeamsToInteger < ActiveRecord::Migration
  def change
  	remove_column :teams, :name
  	add_column :teams, :name, :integer
  end
end
