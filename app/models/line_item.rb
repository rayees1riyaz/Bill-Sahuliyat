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

  base = total_inclusive / (1 + total_gst_rate / 100.0)
  tax = total_inclusive - base

  self.amount = base.round(2)
  self.cgst_amount = (tax / 2).round(2)
  self.sgst_amount = (tax / 2).round(2)

  self.rate = (amount / qty).round(2)
end
end
