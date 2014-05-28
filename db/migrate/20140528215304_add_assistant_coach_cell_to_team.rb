class AddAssistantCoachCellToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :assistant_coach_cell, :string
  end
end
