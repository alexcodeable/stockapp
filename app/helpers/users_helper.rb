module UsersHelper
  def delete_user_data
    @user.user_stocks.destroy_all
    @user.friendships.destroy_all 
  end 
end
