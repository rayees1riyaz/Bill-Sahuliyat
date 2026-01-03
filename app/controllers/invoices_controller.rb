class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all

    # Filter by name or invoice number
    if params[:query].present?
      @invoices = @invoices.where("customer_name LIKE ? OR invoice_number LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    @invoices = @invoices.order(created_at: :desc)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new
    @invoice = Invoice.new
    @invoice.line_items.build
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      InvoiceMailer.send_invoice(@invoice).deliver_later if @invoice.customer_email.present?
      redirect_to @invoice, notice: "Invoice was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update(invoice_params)
      redirect_to @invoice, notice: "Invoice was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    invoice_display_name = "##{@invoice.invoice_number} (#{@invoice.customer_name})"
    @invoice.destroy
    
    respond_to do |format|
      format.html { redirect_to invoices_path, notice: "Invoice #{invoice_display_name} was successfully deleted.", status: :see_other }
      format.turbo_stream { flash.now[:notice] = "Invoice #{invoice_display_name} was successfully deleted." }
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(
      :customer_name, :customer_address, :customer_gstin, :customer_phone, :customer_email, :invoice_date, :financed_by,
      line_items_attributes: [:id, :description, :hsn_code, :quantity, :rate, :cgst_rate, :sgst_rate, :serial_number, :_destroy]
    )
  end
end
