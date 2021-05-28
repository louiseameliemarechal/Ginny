class ProfilesController < ApplicationController
  def index
    @profiles = User.all
  end

  def show
    @profile = User.find(params[:id])
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
  end

  def search
  end
end
