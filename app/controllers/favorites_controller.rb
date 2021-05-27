class FavoritesController < ApplicationController
  before_action :set_doctors, only: [:create]

  def create
    @favorite = Favorite.create(user: current_user, doctor: Doctor.find(params[:doctor_id]))
    redirect_to doctor_path(@favorite.doctor)
  end

  def destroy
    # doctor_favorites = Doctor.find(params[:id]).favorites
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to doctors_path
  end

  private

  def set_doctors
    @doctor = Doctor.find(params[:doctor_id])
  end
end
