class CreateCheckouts < ActiveRecord::Migration[5.2]
  def change
    create_table :checkouts do |t|
      t.references :order, foreign_key: true, index: true, null: false
      t.string :method_type, null: false, comment: 'creditcard'
      t.string :status, null: false, comment: 'confirmed'
      t.timestamps null: false
    end
  end
end
