class ChangeGenderToBoolean < ActiveRecord::Migration
  def up
  	change_table :students do |t|
  		t.change :gender, :boolean
  	end
  	change_table :guardians do |t|
  		t.change :gender, :boolean
  	end
  	change_table :brackets do |t|
  		t.change :gender, :boolean
  	end
  end

  def down
  	change_table :students do |t|
  		t.change :gender, :string
  	end
  	change_table :guardians do |t|
  		t.change :gender, :string
  	end
  	change_table :brackets do |t|
  		t.change :gender, :string
  	end
  end
end
