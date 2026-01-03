class CreateInvoices < ActiveRecord::Migration[8.1]
  def change
    create_table :invoices do |t|
      t.string :customer_name
      t.text :customer_address
      t.string :customer_gstin
      t.string :invoice_number
      t.date :invoice_date
      t.string :financed_by
      t.decimal :sub_total, precision: 15, scale: 2, default: 0
      t.decimal :cgst_total, precision: 15, scale: 2, default: 0
      t.decimal :sgst_total, precision: 15, scale: 2, default: 0
      t.decimal :grand_total, precision: 15, scale: 2, default: 0

      t.timestamps
    end
  end
end
