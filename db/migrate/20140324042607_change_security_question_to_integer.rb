class ChangeSecurityQuestionToInteger < ActiveRecord::Migration
  def change
    remove_column :students, :security_question
    add_column :students, :security_question, :integer
  end
end
