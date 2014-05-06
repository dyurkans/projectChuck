class ChangeGenderToBoolean < ActiveRecord::Migration
  def change
    remove_column :students, :gender
    add_column :students, :gender, :boolean

    remove_column :guardians, :gender
    add_column :guardians, :gender, :boolean

    remove_column :brackets, :gender
    add_column :brackets, :gender, :boolean
  end
end
