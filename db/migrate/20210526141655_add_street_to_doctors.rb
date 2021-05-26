class AddStreetToDoctors < ActiveRecord::Migration[6.0]
  def change
    add_column :doctors, :street, :text
  end
end
