class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.text :picto

      t.timestamps
    end
  end
end
