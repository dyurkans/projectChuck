class Guardian < ActiveRecord::Base
  attr_accessible :active, :cell_phone, :day_phone, :dob, :email, :first_name, :gender, :household_id, :last_name, :receive_texts
end
