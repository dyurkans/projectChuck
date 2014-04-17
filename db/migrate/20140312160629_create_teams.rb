class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :bracket_id
      t.string :name
      t.integer :max_students

      t.timestamps
    end
  end
end
