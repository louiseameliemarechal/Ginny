class AddColumnCarteVitalToDoctors < ActiveRecord::Migration[6.0]
  def change
    add_column :doctors, :carte_vital, :string
  end
end
