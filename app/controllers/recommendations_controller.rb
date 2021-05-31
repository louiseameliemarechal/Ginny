class RecommendationsController < ApplicationController
  def new
    @doctor = Doctor.find(params[:doctor_id])
    @recommendation = Recommendation.new
  end

  def create
    @user = current_user
    @doctor = Doctor.find(params[:doctor_id])
    @recommendation = Recommendation.new(recommendation_params)
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

  def recommendation_params
    params.require(:recommendation).permit(badge_ids: [], tag_ids: [])
  end
end
