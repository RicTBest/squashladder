class WelcomeController < ApplicationController

  before_filter CASClient::Frameworks::Rails::Filter, :only => ["login"]

  def index
  end

  def login
    redirect_to "/"
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

end
