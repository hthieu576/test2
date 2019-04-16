class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true, index: true, null: false
      t.string :status, null: false, comment: 'ordered,..'
      t.text :comment
      t.timestamps null: false
    end
  end
end
