class AddContactDetailsToInvoices < ActiveRecord::Migration[8.1]
  def change
    add_column :invoices, :customer_phone, :string
    add_column :invoices, :customer_email, :string
  end
end
