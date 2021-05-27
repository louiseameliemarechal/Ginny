module ApplicationHelper
  def attribute(doctor)
    return "Madame" if doctor.profession == 'sage-femme'
    return "Docteure" if doctor.gender == 'Femme'
    return "Docteur" if doctor.gender == 'Homme'
  end
end
