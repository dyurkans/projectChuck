class RemoveDobFromGuardian < ActiveRecord::Migration
  def change
    remove_column :guardians, :dob
  end
end
