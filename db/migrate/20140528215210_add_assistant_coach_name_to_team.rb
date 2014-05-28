class AddAssistantCoachNameToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :assistant_coach, :string
  end
end
