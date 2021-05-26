class RemoveAddressFromDoctors < ActiveRecord::Migration[6.0]
  def change
    remove_column :doctors, :address

  end
end
