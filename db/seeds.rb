require 'json'
require 'open-uri'

Favorites.destroy_all
Friendship.destroy_all
Doctor.destroy_all
User.destroy_all


user_1 = User.create!(email: 'test@test.com', username: 'Jean', password: '123456', phone_number: '0669151332') # Add an avatar by default / upload from a URL
user_2 = User.create!(email: 'test2@test.com', username: 'Jeanne', password: '123456', phone_number: '0669151732') # Add an avatar by default / upload from a URL
Friendship.create!(user: user_1, friend: user_2)

Tag.destroy_all
Badge.destroy_all

  url = 'https://public.opendatasoft.com/api/records/1.0/search/?dataset=medecins&q=&rows=50&facet=civilite&facet=column_12&facet=column_13&facet=column_14&facet=column_16&facet=libelle_profession&facet=type_dacte_realise&facet=commune&facet=nom_epci&facet=nom_dep&facet=nom_reg&facet=insee_reg&facet=insee_dep&facet=libelle_regroupement&facet=libelle&facet=libelle_acte_clinique&refine.libelle_profession=Gyn%C3%A9cologue+obst%C3%A9tricien'
  serialized_doctors = URI.open(url).read
  doctors = JSON.parse(serialized_doctors)


doctors['records'].each do |record|
  if record['fields']['coordonnees']

    first_name = record['fields']['nom'].split.first
    last_name = record['fields']['nom'].split.last
    latitude = record['fields']['coordonnees'][0]
    longitude = record['fields']['coordonnees'][1]
    # Creating the address using reverse geocoding
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/#{longitude},#{latitude}.json?access_token=#{ENV['MAPBOX_API_KEY']}"
    address_serialized = URI.open(url).read
    address = JSON.parse(address_serialized)["features"].first
    # address has this format : "7 Villa Gaudelet, 75011 Paris, France"
    street = address["place_name"].split(",")[0]
    city = address["place_name"].split(",")[1]
    country = address["place_name"].split(",")[2]

    new_doctor = Doctor.where(
      first_name: first_name,
      last_name: last_name,
      latitude: latitude,
      longitude: longitude,
      street: street,
      city: city,
      country: country
    ).first_or_initialize

      puts "#{new_doctor.first_name} #{new_doctor.last_name} created" if new_doctor.new_record?

    new_doctor.specialty = record['fields']['nom_acte']
    # new_doctor.profession = record['fields']['libelle_profession']
    new_doctor.profession = ["généraliste", "sage-femme", "gynécologue"].sample
    new_doctor.convention = record['fields']['column_14']
    new_doctor.gender = record['fields']['civilite']
    new_doctor.average_number = record['fields']['tarif_2']
    new_doctor.carte_vital = record['fields']['column_16']

    new_doctor.save!
  end
end


Badge.create!(picto: 'sympa')
Badge.create!(picto: 'empathique')

Tag.create!(picto:'ivg friendly', name: 'ivg')
Tag.create!(picto:'fleuriste', name: 'fleurs')
