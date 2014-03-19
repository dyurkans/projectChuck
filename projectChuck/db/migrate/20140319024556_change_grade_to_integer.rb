class ChangeGradeToInteger < ActiveRecord::Migration
  def up
  	change_table :students do |t|
  		t.change :grade_integer, :integer
  	end
  end

  def down
  	change_table :students do |t|
  		t.change :grade_integer, :string
  	end
  end
end
