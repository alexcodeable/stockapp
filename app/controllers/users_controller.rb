class UsersController < ApplicationController
  before_action :authenticate_user! 
  def portfolio
    @tracked = current_user.stocks
  end

  def search
    render json: params[:friend]
  end
end
