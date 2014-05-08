class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :email
      t.string :role
      t.boolean :active
      t.integer :guardian_id

      t.timestamps
    end
  end
end
