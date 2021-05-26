class AddAddressToDoctors < ActiveRecord::Migration[6.0]
  def change
    add_column :doctors, :street_number, :string
    add_column :doctors, :routes, :string
    add_column :doctors, :city, :string
    add_column :doctors, :country, :string
  end
end
