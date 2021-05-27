class FavoritesController < ApplicationController
  before_action :set_doctors

  def create
    @favorite = Favorite.create(user: current_user, doctor: Doctor.find(params[:doctor_id]))
    redirect_to doctor_path(@favorite.doctor)
  end

  private

  def set_doctors
    @doctor = Doctor.find(params[:doctor_id])
  end
end
