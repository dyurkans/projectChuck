class ChangeStudentGenderToString < ActiveRecord::Migration
  def up
  	change_table :students do |t|
  		t.change :gender, :string
  	end
  end

  def down
  	change_table :students do |t|
  		t.change :gender, :boolean
  	end
  end
end
