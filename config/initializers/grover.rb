# Grover configuration for PDF generation
Grover.configure do |config|
  config.options = {
    format: 'A4',
    margin: {
      top: '0cm',
      right: '0cm',
      bottom: '0cm',
      left: '0cm'
    },
    display_header_footer: false,
    prefer_css_page_size: true,
    print_background: true,
    launch_args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage']
  }
end
