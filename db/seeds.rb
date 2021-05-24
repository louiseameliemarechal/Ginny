require 'json'
require 'open-uri'

50.times do
  url = 'https://public.opendatasoft.com/api/records/1.0/search/?dataset=medecins&q=&facet=civilite&facet=column_12&facet=column_13&facet=column_14&facet=column_16&facet=libelle_profession&facet=type_dacte_realise&facet=commune&facet=nom_epci&facet=nom_dep&facet=nom_reg&facet=insee_reg&facet=insee_dep&facet=libelle_regroupement&facet=libelle&facet=libelle_acte_clinique'
  serialized_doctors = URI.open(url).open
  doctors = JSON.parse(serialized_doctors)
  new_doctor = Doctor.create(
    first_name: records[2]['nom'],
    last_name: records[2]['nom'],
    address: records[2]['adresse'],
    specialty: records[2]['nom_acte'],
    profession: records[2]['libelle_profession'],
    convention: records[2]['column_14'],
    sexe: records[2]['civilite'],
    average_price: records[2]['tarif_2'],
    )
  puts new_doctor.first_name + ' created' if new_book.save
end
