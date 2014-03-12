class ChangeSecurityDataType < ActiveRecord::Migration
  def up
  	change_table :students do |t|
  		t.change :security_question, :text
  		t.change :security_response, :text
  	end
  end

  def down
  	change_table :students do |t|
  		t.change :security_question, :string
  		t.change :security_response, :string
  	end
  end
end
