class AddAssistantCoachNameToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :assistant_coach_name, :string
  end
end
