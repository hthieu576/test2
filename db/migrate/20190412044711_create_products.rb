class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :order, foreign_key: true, index: true, null: false
      t.string :code, null: false
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.timestamps null: false
    end
  end
end
