class MyValidator < ActiveModel::Validator
  def validate(a)
    unless a.start_t < a.end_t
      a.errors[:start_t] << "Start time must be before end time"
    end
  end
end

class Availability < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :end_t, :start_t, :user_id

  belongs_to :user

  validates_presence_of :start_t
  validates_presence_of :end_t
  validates_with MyValidator
end
