class ChangeSchoolCountyType < ActiveRecord::Migration
  def change
    change_column :students, :school_county, 'integer USING CAST(school_county AS integer)'
  end
end
