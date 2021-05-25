class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all

    @markers = @doctors.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
      info_window: render_to_string(partial: "info_window", locals: { doctor: doctor })
    end
  end
end
