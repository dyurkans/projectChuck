class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :student_id
      t.integer :team_id
      t.string :report_card
      t.string :proof_of_insurance
      t.string :physical
      t.date :physical_date
      t.integer :t_shirt_size
      t.date :date
      t.boolean :active

      t.timestamps
    end
  end
end
