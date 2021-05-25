class CreateTagRecos < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_recos do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :recommendation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
