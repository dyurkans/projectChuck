class AddAssistantCoachEmailToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :assistant_coach_email, :string
  end
end
