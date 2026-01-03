class AddSerialNumberToLineItems < ActiveRecord::Migration[8.1]
  def change
    add_column :line_items, :serial_number, :string
  end
end
