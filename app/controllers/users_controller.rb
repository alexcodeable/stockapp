class UsersController < ApplicationController
  before_action :authenticate_user! 
  def portfolio
    @tracked = current_user.stocks
  end
end
