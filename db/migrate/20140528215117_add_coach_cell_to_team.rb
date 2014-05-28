class AddCoachCellToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :coach_cell, :string
  end
end
