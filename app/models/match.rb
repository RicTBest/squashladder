class Match < ActiveRecord::Base
  attr_accessible :date, :loser_score, :winner_score, :winner_id, :loser_id
  belongs_to :winner, :class_name => "User"
  belongs_to :loser, :class_name => "User"

  validates_presence_of :winner_id, :loser_id, :winner_score, :loser_score, :date


  def confirm
    # winner_rating = winner.rating
    # loser_rating = loser.rating
    # Dummy algorithm
    # change = Math.abs(winner_rating - loser_rating) / 2
    winner.rating += 1
    loser.rating -= 1
    User.update_ranks
  end

  def confirmed?
    winner_confirmed and loser_confirmed
  end
end
