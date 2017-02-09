require 'rqrcode'

qrcode = RQRCode::QRCode.new('michelgrootjans')

puts qrcode.as_png.to_s

IO.write('/tmp/qr/michel.png', qrcode.as_png.to_s)