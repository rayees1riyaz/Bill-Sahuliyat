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

    # Math as requested:
    # 1. Total inclusive price for the line
    total_inclusive = unit_price.to_f * qty

    # 2. Tax is calculated ON the total inclusive price
    self.cgst_amount = (total_inclusive * (cgst_rate.to_f || 0)) / 100.0
    self.sgst_amount = (total_inclusive * (sgst_rate.to_f || 0)) / 100.0
    
    # 3. Amount (Total Taxable base) = Total Inclusive - Total Taxes
    self.amount = total_inclusive - cgst_amount - sgst_amount
    
    # 4. Rate (Taxable rate per unit) = Amount / Quantity
    self.rate = amount / qty
  end
end
