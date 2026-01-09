class Invoice < ApplicationRecord
  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy
  accepts_nested_attributes_for :line_items, allow_destroy: true, reject_if: :all_blank

  validates :customer_name, presence: true
  validates :invoice_date, presence: true

  before_validation :generate_invoice_number, on: :create
  before_save :calculate_totals

  def calculate_totals
    line_items.each(&:calculate_amounts)
    self.sub_total = line_items.select { |li| !li.marked_for_destruction? }.sum(&:amount)
    self.cgst_total = line_items.select { |li| !li.marked_for_destruction? }.sum(&:cgst_amount)
    self.sgst_total = line_items.select { |li| !li.marked_for_destruction? }.sum(&:sgst_amount)
    self.grand_total = sub_total + cgst_total + sgst_total
  end

  private

  def generate_invoice_number
    return if invoice_number.present?

    last_invoice = Invoice.order(:id).last
    base_number = last_invoice ? last_invoice.invoice_number.to_i : 500
    new_number = [base_number + 1, 501].max
    self.invoice_number = new_number.to_s
  end
end
