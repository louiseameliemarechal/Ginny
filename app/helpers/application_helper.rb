module ApplicationHelper
  def attribute(doctor)
    return "Madame" if doctor.profession == 'sage-femme'
    return "Docteure" if doctor.gender == 'Femme'
    return "Docteur" if doctor.gender == 'Homme'
  end

  def carte_vital(doctor)
    if doctor.carte_vital == 'Lecteur de carte Sesam Vitale'
      return "Carte vital acceptée"
    else
      return "N'accepte pas la carte vital"
    end
  end

end
