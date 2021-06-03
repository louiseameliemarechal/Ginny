class ProfilesController < ApplicationController
  def index
    @profiles = User.where.not(id: current_user.id).sort_by { |user| current_user.friends.pluck(:id).include?(user.id) ? 0 : 1 }
    if params.dig(:search)
      @profiles = @profiles.where(username: params.dig(:search, :username))
    end
  end

  def show
    @profile = User.find(params[:id])
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
  end
end

