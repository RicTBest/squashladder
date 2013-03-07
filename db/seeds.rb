ric = User.create(
  name: "Ric Best",
  email: "ric.best@yale.edu",
  rating: 1500,
  college: "PC",
  year: "2014",
  netid: "rtb5"
)

rafi = User.create(
  name: "Rafi Khan",
  email: "rafi.khan@yale.edu",
  rating: 1400,
  college: "PC",
  year: "2015",
  netid: "fak23"
)

game = Match.create(
  winner_id: ric.id,
  loser_id: rafi.id,
  winner_score: 3,
  loser_score: 2
)

a = Availability.create(
  user_id: 2,
  start_t: Time.now + 5.day,
  end_t: Time.now + 5.day + 1.hour
)

b = Availability.create(
  user_id: 2,
  start_t: Time.now + 5.day + 2.hour,
  end_t: Time.now + 5.day + 3.hour
)

puts "Done seeding!"