class AddNameToBadges < ActiveRecord::Migration[6.0]
  def change
    add_column :badges, :name, :string
  end
end
