require 'json'
require 'open-uri'
  # Cleaning
  TagReco.destroy_all
  puts "Tag cleaned"
  Tag.destroy_all
  BadgeReco.destroy_all
  puts "Badges cleaned"
  Badge.destroy_all
  Recommendation.destroy_all
  Favorite.destroy_all
  Doctor.destroy_all
  puts "Doctors cleaned"
  Friendship.destroy_all
  # Friendship clean with User dependent: :destroy
  User.destroy_all
  puts "Users cleaned"

  # Creation of Badges
Badge.create!(name: 'écoute', picto: 'écoute')
Badge.create!(name: 'empathie', picto: 'empathie')
Badge.create!(name: 'pédagogie', picto: 'pédagogie')
puts "#{Badge.count} badges created"
  # Creation of Tags
Tag.create!(name: 'IVG-friendly', picto: 'IVG-friendly')
Tag.create!(name: 'Endométriose', picto: 'Endométriose')
Tag.create!(name: 'DIU', picto: 'DIU')
Tag.create!(name: 'LGBT', picto: 'LGBT')
puts "#{Tag.count} tags created"



  # Creation of Users
user_1 = User.create!(email: 'test@test.com', username: 'Jean', password: '123456', phone_number: '0669151332')
user_2 = User.create!(email: 'test2@test.com', username: 'Jeanne', password: '123456', phone_number: '0669151732')
user_3 = User.create!(email: 'test3@test.com', username: 'Rosie', password: '123456', phone_number: '169151732')
user_4 = User.create!(email: 'test4@test.com', username: 'Abigail', password: '123456', phone_number: '2669151732')
user_5 = User.create!(email: 'test5@test.com', username: 'Dahlia', password: '123456', phone_number: '669151732')
puts "Users created"

    # Creation of Friendship
Friendship.create!(user: user_1, friend: user_2)
Friendship.create!(user: user_1, friend: user_3)
Friendship.create!(user: user_1, friend: user_4)
Friendship.create!(user: user_1, friend: user_5)
puts "Friendships initiated"

  # Imporations of Doctors
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
  # Creation of Doctor instances
    new_doctor = Doctor.where(
      first_name: first_name,
      last_name: last_name,
      latitude: latitude,
      longitude: longitude,
      street: street,
      city: city,
      country: country
    ).first_or_initialize

      puts "#{new_doctor.first_name.capitalize} #{new_doctor.last_name.capitalize} created" if new_doctor.new_record?

    new_doctor.specialty = record['fields']['nom_acte']
    # new_doctor.profession = record['fields']['libelle_profession']
    new_doctor.profession = ["généraliste", "sage-femme", "gynécologue"].sample
    new_doctor.convention = record['fields']['column_14'].delete(',')
    # Remove the "," from the convention string
    new_doctor.gender = record['fields']['civilite']
    new_doctor.average_number = record['fields']['tarif_2']
    new_doctor.carte_vital = record['fields']['column_16']

    new_doctor.save!
  end
end

# Creation of Recommandations, Favorites, Badges & Tags for each User
User.all.each do |user|
  Favorite.create!(user: user, doctor: Doctor.all.sample)
end

puts "Users favorites created"

Doctor.all.each do |doctor|
  new_reco = Recommendation.create!(user: User.all.sample, doctor: doctor )
  (1..3).to_a.sample.times do
    BadgeReco.create!(recommendation: new_reco, badge: Badge.all.sample)
    TagReco.create!(recommendation: new_reco, tag: Tag.all.sample)
  end
end

puts "All doctors have tags & labels now!"

