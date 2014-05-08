class ChangeGradeToInteger < ActiveRecord::Migration
  def change
    remove_column :students, :grade_integer
    add_column :students, :grade_integer, :integer
  end
end
