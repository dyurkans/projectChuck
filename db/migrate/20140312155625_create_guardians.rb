class CreateGuardians < ActiveRecord::Migration
  def change
    create_table :guardians do |t|
      t.integer :household_id
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :cell_phone
      t.string :day_phone
      t.boolean :receive_texts
      t.string :email
      t.string :gender
      t.boolean :active

      t.timestamps
    end
  end
end
