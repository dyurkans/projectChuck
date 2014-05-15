class AddAccountabilityToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :volunteer_initials, :string
  end
end
