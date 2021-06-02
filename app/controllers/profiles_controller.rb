class ProfilesController < ApplicationController
  def index
    @profiles = current_user.friends
    if params.dig(:search)
      @profiles = @profiles.where(username: params.dig(:search, :username))
    end
  end

  def show
    @profile = User.find(params[:id])
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
  end
end
