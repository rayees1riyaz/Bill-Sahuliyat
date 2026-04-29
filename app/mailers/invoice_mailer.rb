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
    # Use InvoicesController to render the PDF template properly with routing context if needed
    html = InvoicesController.render(
      template: 'invoices/pdf',
      layout: 'pdf',
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
