class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
