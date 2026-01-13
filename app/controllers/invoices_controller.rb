class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = current_user.invoices

    # Filter by name or invoice number
    if params[:query].present?
      @invoices = @invoices.where("customer_name LIKE ? OR invoice_number LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    @invoices = @invoices.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @invoice = current_user.invoices.build
    @invoice.line_items.build
  end

  def create
    @invoice = current_user.invoices.build(invoice_params)
    if @invoice.save
      InvoiceMailer.send_invoice(@invoice).deliver_later if @invoice.customer_email.present?
      redirect_to @invoice, notice: "Invoice was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to @invoice, notice: "Invoice was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    invoice_display_name = "##{@invoice.invoice_number} (#{@invoice.customer_name})"
    @invoice.destroy
    
    respond_to do |format|
      format.html { redirect_to invoices_path, notice: "Invoice #{invoice_display_name} was successfully deleted.", status: :see_other }
      format.turbo_stream { flash.now[:notice] = "Invoice #{invoice_display_name} was successfully deleted." }
    end
  end

  private

  def set_invoice
    @invoice = current_user.invoices.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(
      :customer_name, :customer_address, :customer_gstin, :customer_phone, :customer_email, :invoice_date, :financed_by,
      line_items_attributes: [:id, :description, :hsn_code, :quantity, :rate, :unit_price, :cgst_rate, :sgst_rate, :serial_number, :_destroy]
    )
  end
end
