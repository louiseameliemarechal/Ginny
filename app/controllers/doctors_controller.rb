class DoctorsController < ApplicationController
  before_action :set_doctor, only: :show

  def index
    @doctors = Doctor.all

    if params[:specialty].present?
      @doctors = @doctors.where(specialty: params[:specialty])
    end

    if params[:gender].present?
      @doctors = @doctors.where(gender: params[:gender].capitalize)
    end

    if params[:profession].present?
      @doctors = @doctors.where(profession: params[:profession])
    end

    if params[:convention].present?
      @doctors = @doctors.where(convention: params[:convention])
    end

    # Allow to center the map on user location but not implemented yet
    # raise
    # if params[:location]
    #   @doctors = @doctors.near(params[:location], 10)
    # end

    @markers = @doctors.map do |doctor|
      {
        latitude: doctor.latitude,
        longitude: doctor.longitude,
        info_window: render_to_string(partial: "info_window", locals: { doctor: doctor })
      }
    end
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end
end
