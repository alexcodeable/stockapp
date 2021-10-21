class HomeController < ApplicationController
  before_action :authenticate_user!, only: [ :friends]
  def index
  end

  def pricing
  end

  def friends
    @friends = current_user.friends
  end

end
