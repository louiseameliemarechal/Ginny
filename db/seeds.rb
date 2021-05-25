require 'json'
require 'open-uri'

Doctor.destroy_all

User.create(email: 'test@test.com', username: 'Jean', password: '123456', phone_number: '066915133')

  url = 'https://public.opendatasoft.com/api/records/1.0/search/?dataset=medecins&q=&rows=50&facet=civilite&facet=column_12&facet=column_13&facet=column_14&facet=column_16&facet=libelle_profession&facet=type_dacte_realise&facet=commune&facet=nom_epci&facet=nom_dep&facet=nom_reg&facet=insee_reg&facet=insee_dep&facet=libelle_regroupement&facet=libelle&facet=libelle_acte_clinique&refine.libelle_profession=Gyn%C3%A9cologue+obst%C3%A9tricien'
  serialized_doctors = URI.open(url).read
  doctors = JSON.parse(serialized_doctors)

doctors['records'].each do |record|
  new_doctor = Doctor.create!(
    first_name: record['fields']['nom'].split.first,
    last_name: record['fields']['nom'].split.last,
    address: record['fields']['adresse'],
    specialty: record['fields']['nom_acte'],
    profession: record['fields']['libelle_profession'],
    convention: record['fields']['column_14'],
    gender: record['fields']['civilite'],
    average_number: record['fields']['tarif_2']
    )
    puts "#{new_doctor.first_name} #{new_doctor.last_name} created" if new_doctor.save
end


Badge.create(picto: 'sympa')
Badge.create(picto: 'empathique')

Tag.create(picto:'ivg friendly', name: 'ivg')
Tag.create(picto:'fleuriste', name: 'fleurs')
