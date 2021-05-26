class DoctorsController < ApplicationController

  def index
    @doctors = Doctor.all

    if params.dig(:search, :specialty).present?
      @doctors = @doctors.where(specialty: params.dig(:search, :specialty))
    end

    if params.dig(:search, :gender).present?
      @doctors = @doctors.where(gender: params.dig(:search, :gender)&.capitalize)
    end

    if params.dig(:search, :profession).present?
      @doctors = @doctors.where(profession: params.dig(:search, :profession))
    end

    if params.dig(:search, :convention).present?
      @doctors = @doctors.where(convention: params.dig(:search, :convention))
    end

    if params[:search][:tags].reject(&:empty?).present?
      @doctors = @doctors.joins(:tags).where(tags: {name: params[:search][:tags].reject(&:empty?)})
    end

    if params[:search][:badges].reject(&:empty?).present?
      @doctors = @doctors.joins(:badges).where(badges: {picto: params[:search][:badges].reject(&:empty?)})
    end

    @markers = @doctors.map do |doctor|
      {
        latitude: doctor.latitude,
        longitude: doctor.longitude,
        info_window: render_to_string(partial: "info_window", locals: { doctor: doctor })
      }
    end

  end

  def show
    @doctor = Doctor.find(params[:id])
  end
end
