# This class is now useless (and excessive, as we noted before). You can remove it.
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
  # validates_with MyValidator
  # This call is simpler
  validate :check_times

  # Anything after protected means that only this class and its extensions
  # can call this method
  protected

  def check_times
    # Here, it's implicit that 'self' is the model. Saying start_t is the 
    # same as saying self.start_t. In Rails 3.2, you can omit the self,
    # but before you couldn't do that
    unless start_t < end_t
      errors.add :start_t, "Start time must be before end time"
    end
  end
end
