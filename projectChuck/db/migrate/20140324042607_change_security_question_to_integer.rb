class ChangeSecurityQuestionToInteger < ActiveRecord::Migration
  def up
  	change_table :students do |t|
  		t.change :security_question, :integer
  	end
  end

  def down
  	change_table :students do |t|
  		t.change :security_question, :string
  	end
  end
end
