class ProfilesController < ApplicationController
  def show
    @profile = User.find(params[:id])
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
  end
end
