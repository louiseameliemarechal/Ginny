module ApplicationHelper
  def attribute(doctor)
    return "Mme" if doctor.profession == 'sage-femme'
    return "Dre" if doctor.gender == 'Femme'
    return "Dr" if doctor.gender == 'Homme'
  end
end
