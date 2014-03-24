class HouseholdsController < ApplicationController
  def new
    @household = Household.new
  end
end
