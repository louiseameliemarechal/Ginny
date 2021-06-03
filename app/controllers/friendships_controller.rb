class FriendshipsController < ApplicationController
  def create
    # @friend = User.find(params[:user_id])
    @friendship = Friendship.create(user: current_user, friend: User.find(params[:profile_id]))
    redirect_to profiles_path
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to profiles_path
  end
end
