class CreateRegistrationForms < ActiveRecord::Migration
  def change
    create_table :registration_forms do |t|

      t.timestamps
    end
  end
end
