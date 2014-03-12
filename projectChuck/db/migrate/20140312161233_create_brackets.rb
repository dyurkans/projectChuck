class CreateBrackets < ActiveRecord::Migration
  def change
    create_table :brackets do |t|
      t.integer :tournament_id
      t.string :gender
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end
end
