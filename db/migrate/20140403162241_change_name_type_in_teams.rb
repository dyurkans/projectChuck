class ChangeNameTypeInTeams < ActiveRecord::Migration
  def up
  	change_column :teams, :name, :string
  end

  def down
  	change_column :teams, :name, :integer
  end
end
