require 'json'
require 'rqrcode'
require 'rmagick'
include Magick

def filename_for(code)
  "qr/#{code['shortCode']}.png"
end

def joined_filename_for(code1, code2)
  "qr/#{code1['shortCode']}_#{code2['shortCode']}.png"
end

def qr_code_for(code)
  "http://www.slingshot.company?s=#{code['shortCode']}"
end

def generate_single_qr_file(code)
  options = {
      size: 120,
      border_modules: 2,
      file: filename_for(code)
  }
  RQRCode::QRCode.new(qr_code_for(code)).as_png(options)
end

def annotated_file_for(code)
  generate_single_qr_file(code)

  text = Draw.new
  text.font_family = 'helvetica'
  text.pointsize = 12
  text.gravity = SouthGravity

  image1 = Image.read(filename_for(code)).first
  text.annotate(image1, 0, 0, 0, 5, code['shortCode'])
  image1
end

JSON.parse(File.read(ARGV[0])).each_slice(2) do |code1, code2|
  row = ImageList.new
  row.push(annotated_file_for(code1))
  row.push(annotated_file_for(code2))

  big_image = ImageList.new
  big_image.push (row.append(false))
  big_image.write(joined_filename_for(code1, code2))

  File.delete(filename_for(code1))
  File.delete(filename_for(code2))
end
