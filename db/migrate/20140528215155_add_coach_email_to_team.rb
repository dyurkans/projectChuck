class AddCoachEmailToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :coach_email, :string
  end
end
