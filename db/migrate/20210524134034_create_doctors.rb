class CreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :phone_number
      t.text :doctolib_url
      t.string :specialty
      t.string :convention
      t.string :profession
      t.integer :average_number
      t.string :gender

      t.timestamps
    end
  end
end
