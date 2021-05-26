class RemoveRoutesFromDoctors < ActiveRecord::Migration[6.0]
  def change
    remove_column :doctors, :street_number, :routes
  end
end
