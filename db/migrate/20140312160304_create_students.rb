class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :household_id
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :cell_phone
      t.string :school
      t.string :school_county
      t.string :grade_integer
      t.boolean :gender
      t.string :emergency_contact_name
      t.string :emergency_contact_phone
      t.string :birth_certificate
      t.text :allergies
      t.text :medications
      t.string :security_question
      t.string :security_response
      t.boolean :active

      t.timestamps
    end
  end
end
