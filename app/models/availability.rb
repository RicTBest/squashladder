class Availability < ActiveRecord::Base
  attr_accessible :end_t, :start_t, :user_id

  belongs_to :user
end
