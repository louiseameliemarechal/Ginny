class DoctorsController < ApplicationController
  # before_action :set_doctor, only: :edit

  def index
    @doctors = Doctor.all

    if params.dig(:search, :address).present?
      @doctors = @doctors.near(params.dig(:search, :address), 10)
    end

    if params.dig(:search, :name_or_specialty).present?
      @doctors = @doctors.search_by_name_and_specialty(params.dig(:search, :name_or_specialty))
    end

    # if params.dig(:search, :specialty).present?
    #  @doctors = @doctors.where(specialty: params.dig(:search, :specialty))
    # end

    if params.dig(:search, :gender).present?
      @doctors = @doctors.where(gender: params.dig(:search, :gender)&.capitalize)
    end

    if params.dig(:search, :profession).present?
      @doctors = @doctors.where(profession: params.dig(:search, :profession))
    end

    if params.dig(:search, :convention).present?
      @doctors = @doctors.where(convention: params.dig(:search, :convention))
    end

    if params.dig(:search, :tags).present? && params.dig(:search, :tags).reject(&:empty?).present?
      @doctors = @doctors.joins(:tags).where(tags: {name: params[:search][:tags].reject(&:empty?)})
    end

    if params.dig(:search, :badges).present? && params.dig(:search, :badges).reject(&:empty?).present?
      @doctors = @doctors.joins(:badges).where(badges: {picto: params[:search][:badges].reject(&:empty?)})
    end

    @markers = @doctors.map do |doctor|
      case doctor.profession
      when "sage-femme"
        icon = "sage-femme-w-icon"
      when "généraliste"
        icon = "generaliste-m-icon" if doctor.gender == "Homme"
        icon = "generaliste-w-icon" if doctor.gender == "Femme"
      when "gynécologue"
        icon = "gyneco-m-icon" if doctor.gender == "Homme"
        icon = "gyneco-w-icon" if doctor.gender == "Femme"
      end
      {
        latitude: doctor.latitude,
        longitude: doctor.longitude,
        icon: icon,
        info_window: render_to_string(partial: "marker_window", locals: { doctor: doctor })
      }
    end
  end

  def show
    @doctor = Doctor.find(params[:id])
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end
end
