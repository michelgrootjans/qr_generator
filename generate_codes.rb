require 'json'

codes = [
    {'qrCode': 'http://www.slingshot.company?s=1234abCD', 'shortcode': '1234abCD'},
    {'qrCode': 'http://www.slingshot.company?s=1234abCE', 'shortcode': '1234abCE'}
]

File.open("qr/codes.json", "w") { |f| f.write(codes.to_json) }
