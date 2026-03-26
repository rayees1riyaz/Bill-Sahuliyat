class LineItem < ApplicationRecord
  belongs_to :invoice

  validates :description, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :rate, numericality: { greater_than_or_equal_to: 0 }

  before_save :calculate_amounts
  after_initialize :calculate_amounts, if: :new_record?

  def calculate_amounts
  return unless unit_price.present?

  qty = quantity.to_f > 0 ? quantity.to_f : 1
  total_inclusive = unit_price.to_f * qty

  cgst = total_inclusive * cgst_rate.to_f / 100.0
  sgst = total_inclusive * sgst_rate.to_f / 100.0

  # keep 2 decimal precision
  self.cgst_amount = cgst.round(2)
  self.sgst_amount = sgst.round(2)

  self.amount = (total_inclusive - cgst_amount - sgst_amount).round(2)
  self.rate   = (amount / qty).round(2)
end
end
