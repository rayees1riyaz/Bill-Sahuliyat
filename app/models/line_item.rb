class LineItem < ApplicationRecord
  belongs_to :invoice

  validates :description, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :rate, numericality: { greater_than_or_equal_to: 0 }

  before_save :calculate_amounts
  after_initialize :calculate_amounts, if: :new_record?

  def calculate_amounts
    self.amount = (quantity.to_f || 0) * (rate.to_f || 0)
    self.cgst_amount = amount * (cgst_rate.to_f || 0) / 100.0
    self.sgst_amount = amount * (sgst_rate.to_f || 0) / 100.0
  end
end
