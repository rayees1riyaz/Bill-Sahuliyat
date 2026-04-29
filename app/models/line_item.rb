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
    
    total_tax_rate = cgst_rate.to_f + sgst_rate.to_f
    
    if total_tax_rate > 0
      # Extract the base amount from the inclusive total
      base_amount = total_inclusive / (1.0 + (total_tax_rate / 100.0))
    else
      base_amount = total_inclusive
    end

    cgst = base_amount * (cgst_rate.to_f / 100.0)
    sgst = base_amount * (sgst_rate.to_f / 100.0)

    # Keep 2 decimal precision for taxes
    self.cgst_amount = cgst.round(2)
    self.sgst_amount = sgst.round(2)

    # Derive amount by subtracting exact rounded taxes from total 
    # to avoid 1 cent rounding mismatches (amount + taxes must exactly equal total)
    self.amount = (total_inclusive - self.cgst_amount - self.sgst_amount).round(2)
    self.rate   = (self.amount / qty).round(2)
  end
end
