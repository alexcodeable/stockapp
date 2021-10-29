class FriendshipsController < ApplicationController
  def create
    friend = User.friendly.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "You are now following #{friend.full_name}"
    else
      flash[:alert] = "Something went wrong with the following request"
    end
    redirect_to friends_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "You stop following #{}"
    redirect_to friends_path
  end
end
