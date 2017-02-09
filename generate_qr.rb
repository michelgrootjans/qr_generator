require 'json'
require 'rqrcode'
require 'rmagick'
include Magick

def filename_for(code)
  "qr/#{code['shortcode']}.png"
end

def joined_filename_for(code1, code2)
  "qr/#{code1['shortcode']}_#{code2['shortcode']}.png"
end

def generate_single_qr_file(code)
  options = {
      size: 120,
      border_modules: 4,
      file: filename_for(code)
  }
  RQRCode::QRCode.new(code['qrCode']).as_png(options)
end

def annotated_file_for(code1)
  text = Draw.new
  text.font_family = 'helvetica'
  text.pointsize = 12
  text.gravity = SouthGravity

  image1 = Image.read(filename_for(code1)).first
  text.annotate(image1, 0, 0, 0, 5, code1['shortcode'])
  image1
end

JSON.parse(File.read('qr/codes.json')).each_slice(2) do |code1, code2|
  row = ImageList.new
  generate_single_qr_file(code1)
  row.push(annotated_file_for(code1))
  generate_single_qr_file(code2)
  row.push(annotated_file_for(code2))

  big_image = ImageList.new
  big_image.push (row.append(false))
  big_image.write(joined_filename_for(code1, code2))

  File.delete(filename_for(code1))
  File.delete(filename_for(code2))
end
