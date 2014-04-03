class ChangeNameTypeInTeamsToInteger < ActiveRecord::Migration
  def up
  	change_column :teams, :name, :integer
  end

  def down
  	change_column :teams, :name, :string
  end
end
