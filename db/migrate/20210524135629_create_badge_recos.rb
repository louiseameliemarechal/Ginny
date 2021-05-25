class CreateBadgeRecos < ActiveRecord::Migration[6.0]
  def change
    create_table :badge_recos do |t|
      t.references :badge, null: false, foreign_key: true
      t.references :recommendation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
