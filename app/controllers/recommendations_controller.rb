class RecommendationsController < ApplicationController
  before_action :set_doctor, only: [:new, :create]

  def new
    @recommendation = Recommendation.new
  end

  def create
    @user = current_user
    Recommendation.find_by(user: @user, doctor: @doctor).destroy if Recommendation.find_by(user: @user, doctor: @doctor)
    new_attributes = {
      badge_ids: recommendation_params[:badge_ids],
      tags: recommendation_params[:tags].reject(&:empty?).map { |tag_name| Tag.find_by(name: tag_name) }
    }
    @recommendation = Recommendation.new(new_attributes)
    @recommendation.user = @user
    @recommendation.doctor = @doctor
    @recommendation.save!
    # params[:recommendation][:badge_ids].reject(&:empty?).each do |badge_id|
    #  BadgeReco.create!(recommendation: @recommendation, badge_id: badge_id.to_i)
    # end
    # params[:recommendation][:tag_ids].reject(&:empty?).each do |tag_id|
    #  TagReco.create!(recommendation: @recommendation, tag_id: tag_id.to_i)
    # end
    redirect_to doctor_path(@doctor)
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def recommendation_params
    params.require(:recommendation).permit(badge_ids: [], tags: [])
  end
end
