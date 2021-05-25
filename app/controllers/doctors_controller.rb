class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all

    if params[:specialty].present?
      @doctors = @doctors.where(specialty: params[:specialty])
    end

     if params[:gender].present?
      @doctors = @doctors.where(gender: params[:gender])
    end

    if params[:profession].present?
      @doctors = @doctors.where(profession: params[:profession])
    end

    if params[:convention].present?
      @doctors = @doctors.where(convention: params[:convention])
    end

    # raise
    # if params[:location]
    #   @doctors = @doctors.near(params[:location], 10)
    # end
    @markers = @doctors.geocoded.map do |doctor|
      {
        latitude: doctor.latitude,
        longitude: doctor.longitude,
        info_window: render_to_string(partial: "info_window", locals: { doctor: doctor })
      }
    end
  end
end
