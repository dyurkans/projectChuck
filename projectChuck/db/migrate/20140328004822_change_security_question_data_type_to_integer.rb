class ChangeSecurityQuestionDataTypeToInteger < ActiveRecord::Migration
  def up
    change_column :students, :security_question, :integer
  end

  def down
   change_column :students, :security_question, :string
  end
end