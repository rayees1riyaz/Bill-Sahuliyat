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

  total_gst_rate = cgst_rate.to_f + sgst_rate.to_f

  # Correct base calculation
  self.amount = total_inclusive / (1 + total_gst_rate / 100.0)

  # Total tax
  total_tax = total_inclusive - amount

  # Split tax
  self.cgst_amount = total_tax / 2
  self.sgst_amount = total_tax / 2

  # Per unit rate
  self.rate = amount / qty
end
end
