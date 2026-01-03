class CreateLineItems < ActiveRecord::Migration[8.1]
  def change
    create_table :line_items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.text :description
      t.string :hsn_code
      t.integer :quantity
      t.decimal :rate, precision: 15, scale: 2, default: 0
      t.decimal :amount, precision: 15, scale: 2, default: 0
      t.decimal :cgst_rate, precision: 5, scale: 2, default: 0
      t.decimal :cgst_amount, precision: 15, scale: 2, default: 0
      t.decimal :sgst_rate, precision: 5, scale: 2, default: 0
      t.decimal :sgst_amount, precision: 15, scale: 2, default: 0

      t.timestamps
    end
  end
end
