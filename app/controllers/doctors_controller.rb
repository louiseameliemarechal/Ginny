class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all

    @markers = @doctors.geocoded.map do |doctor|
      {
        latitude: doctor.latitude,
        longitude: doctor.longitude,
        info_window: render_to_string(partial: "info_window", locals: { doctor: doctor })
      }
    end
  end
end
