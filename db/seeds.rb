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
Badge.create!(name: 'ecoute', picto: 'ecoute')
Badge.create!(name: 'empathie', picto: 'empathie')
Badge.create!(name: 'pedagogie', picto: 'pedagogie')
puts "#{Badge.count} badges created"
  # Creation of Tags
Tag.create!(name: 'IVG-friendly', picto: 'IVG-friendly')
Tag.create!(name: 'Endométriose', picto: 'Endométriose')
Tag.create!(name: 'DIU', picto: 'DIU')
Tag.create!(name: 'LGBT', picto: 'LGBT')
puts "#{Tag.count} tags created"



  # Creation of Users
file1 = URI.open("https://avatars.githubusercontent.com/u/78623015?v=4")
file2 = URI.open("https://bandofsistersparis.com/wp-content/uploads/2019/09/MDF-LOGO.png")
file3 = URI.open("https://yt3.ggpht.com/ytc/AAUvwngMY5Uy5pAvY0z0myT76YD7__Vs-iDbEryL3xas=s176-c-k-c0x00ffffff-no-rj")
file4 = URI.open("https://rlv.zcache.fr/sticker_carre_logo_du_symbole_feministe-rcbc7e60783b843628a9ed53037ee6826_0ugmc_8byvr_540.jpg")
file5 = URI.open("https://balancetonuterus.com/wp-content/uploads/2019/09/Logo-Balance-ton-ute%CC%81rus-01-e1568292886721.png")


# file = URI.open("https://source.unsplash.com/random/100x100")
user_1 = User.create!(email: 'test@test.com', username: 'Amel', password: '123456', phone_number: '0669151332')
User.last.photo.attach(io: file1, filename: 'nes.jpg', content_type: 'image/jpg')
User.last.save!
puts "#{user_1.username} has joined Ginny"
user_2 = User.create!(email: 'test2@test.com', username: 'Maison des femmes', password: '123456', phone_number: '0669151732')
user_2.photo.attach(io: file2, filename: 'nes.jpg', content_type: 'image/jpg')
user_2.save!
puts "#{user_2.username} has joined Ginny"
user_3 = User.create!(email: 'test3@test.com', username: 'Gyn&Co', password: '123456', phone_number: '169151732')
user_3.photo.attach(io: file3, filename: 'nes.jpg', content_type: 'image/jpg')
user_3.save!
puts "#{user_3.username} has joined Ginny"
user_4 = User.create!(email: 'test4@test.com', username: 'Osez le féminisme', password: '123456', phone_number: '2669151732')
user_4.photo.attach(io: file4, filename: 'nes.jpg', content_type: 'image/jpg')
user_4.save!
puts "#{user_4.username} has joined Ginny"
user_5 = User.create!(email: 'test5@test.com', username: 'Balance ton utérus', password: '123456', phone_number: '669151732')
user_5.photo.attach(io: file5, filename: 'nes.jpg', content_type: 'image/jpg')
user_5.save!
puts "#{user_5.username} has joined Ginny"
puts "Users created"

    # Creation of Friendship
Friendship.create!(user: user_1, friend: user_2)
Friendship.create!(user: user_1, friend: user_3)
Friendship.create!(user: user_1, friend: user_4)
Friendship.create!(user: user_1, friend: user_5)
puts "Friendships initiated"

  # Imporations of Doctors
url = 'https://public.opendatasoft.com/api/records/1.0/search/?dataset=medecins&q=&rows=50&facet=civilite&facet=column_12&facet=column_13&facet=column_14&facet=column_16&facet=libelle_profession&facet=type_dacte_realise&facet=commune&facet=nom_epci&facet=nom_dep&facet=nom_reg&facet=insee_reg&facet=insee_dep&facet=libelle_regroupement&facet=libelle&facet=libelle_acte_clinique&refine.libelle_profession=Gyn%C3%A9cologue+obst%C3%A9tricien&refine.nom_dep=PARIS'
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
    new_doctor.convention = ["Secteur 1", "Secteur 2", "Secteur 2 sans suivi des soins"].sample
    # Remove the "," from the convention string
    new_doctor.gender = record['fields']['civilite']
    new_doctor.average_number = ["90-110", "100-120", "110-140"].sample
    new_doctor.carte_vital = "Carte Vitale acceptée"
    new_doctor.save!
  end
end

# Creation of Recommandations, Favorites, Badges & Tags for each User

User.all.each do |user|

  doctor_id = Doctor.first.id
  6.times do
    Favorite.create!(user: user, doctor: Doctor.find(doctor_id))
    doctor_id +=1
    # Avoid to have same Favorite created twice
  end
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

