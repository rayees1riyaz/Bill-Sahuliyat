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

  # calculate tax
  cgst = total_inclusive * cgst_rate.to_f / 100.0
  sgst = total_inclusive * sgst_rate.to_f / 100.0

  # ✅ round tax to whole numbers (important)
  self.cgst_amount = cgst.round(0)
  self.sgst_amount = sgst.round(0)

  # ✅ adjust base so total always matches
  self.amount = total_inclusive - cgst_amount - sgst_amount

  # per unit rate
  self.rate = (amount / qty).round(2)
end
end
