class InvoiceMailer < ApplicationMailer
  default from: 'saadatenterprises0@gmail.com'

  def send_invoice(invoice)
    @invoice = invoice
    
    # Generate PDF using Grover
    pdf_content = generate_pdf(invoice)
    
    attachments["Invoice_#{@invoice.invoice_number}.pdf"] = pdf_content
    
    mail(
      to: @invoice.customer_email,
      subject: "Tax Invoice from Saadat Enterprises - ##{@invoice.invoice_number}"
    )
  end

  private

  def generate_pdf(invoice)
    # Render the invoice show page to a string
    # We use a separate controller action or just render the view directly
    html = ActionController::Base.new.render_to_string(
      template: 'invoices/show',
      layout: 'print', # Use a minimal print layout or the default if it works
      assigns: { invoice: invoice }
    )
    
    # Configure Grover to generate PDF from HTML
    grover = Grover.new(html, {
      format: 'A4',
      margin: {
        top: '0cm',
        right: '0cm',
        bottom: '0cm',
        left: '0cm'
      },
      display_header_footer: false,
      prefer_css_page_size: true,
      print_background: true
    })
    
    grover.to_pdf
  end
end
