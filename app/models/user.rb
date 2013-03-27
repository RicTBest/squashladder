class User < ActiveRecord::Base
  attr_accessible :name, :netid, :rating, :email, :year, :college

  has_many :won_matches, :class_name => "Match", :foreign_key => "winner_id"
  has_many :lost_matches, :class_name => "Match", :foreign_key => "loser_id"
  has_many :availabilities

  validates_presence_of :netid, :name, :rating, :email
  validates_uniqueness_of :netid

  after_create { User.update_ranks }

  def wins
    won_matches.where(tie: false)
  end

  def losses
    lost_matches.where(tie: false)
  end

  # Includes ties!
  def matches
    won_matches + lost_matches
  end

  def above_ranks
    stop = offset = rank > 1 ? rank - 2 : 0
    User.order("rank").where(rank < stop)
  end

  def nearby_ranks
    offset = rank > 1 ? rank - 2 : 0
    # fromBottom = rank - User.count
    # if fromBottom < 5
    #   offset = rank - 5 - fromBottom
    # end
    User.order("rank").offset(offset).limit(3)
  end

  def below_ranks
    User.order("rank").offset(rank+2)
  end

  def disputed
    matches.where(disputed: true)
  end

  def disputed_percentage
    (disputed.count.to_f / matches.count) * 100.0
  end

  def future_availabilities
    self.availabilities.where("start_t > ? ", Time.now).order("start_t").limit(10)
  end

  def User.update_ranks
    users = User.order("rating DESC")
    new_rank = 1
    users.each do |u|
      u.rank = new_rank
      u.save
      new_rank+=1
    end
  end

  def User.create_from_directory(netid)
    name_regex = /^\s+Name:/
    email_regex = /Email Address:/
    college_regex = /Residential College:/
    year_regex = /Class Year:/

    browser = User.make_cas_browser
    browser.get("http://directory.yale.edu/phonebook/index.htm?searchString=uid%3D#{netid}")

    u = User.new
    u.netid = netid
    browser.page.search('tr').each do |tr|
      field = tr.at('th').text
      value = tr.at('td').text.strip
      case field
      when name_regex
        u.name ||= value
      when email_regex
        u.email = value
      when college_regex
        u.college = value
      when year_regex
        u.year = value
      end
    end
    u.save!
    u
  end

  def User.make_cas_browser
    browser = Mechanize.new
    browser.get( 'https://secure.its.yale.edu/cas/login' )
    form = browser.page.forms.first
    form.username = ENV['CAS_NETID']
    form.password = ENV['CAS_PASS']
    form.submit
    browser
  end
end
