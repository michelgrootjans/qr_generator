require 'rqrcode'

qr1 = RQRCode::QRCode.new('michelgrootjans')
qr2 = RQRCode::QRCode.new('billgates')

# puts qrcode.as_png.to_s

IO.write('qr/michel.png', qr1.as_png.to_s)
IO.write('qr/bill.png', qr2.as_png.to_s)

require 'rmagick'
#image_list = Magick::ImageList.new("/tmp/qr/michel.png", "/tmp/qr/bill.png")
#image_list.write("/tmp/qr/combine.png")

include Magick
#this will be the final image
big_image = ImageList.new

#this is an image containing first row of images
first_row = ImageList.new
#this is an image containing second row of images
#second_row = ImageList.new

#adding images to the first row (Image.read returns an Array, this is why .first is needed)
first_row.push(Image.read("qr/michel.png").first)
first_row.push(Image.read("qr/bill.png").first)

# adding first row to big image and specify that we want images in first row to
# be appended in a single image on the same row
# - argument false on append does that
big_image.push (first_row.append(false))

#same thing for second row
# second_row.push(Image.read("3.png").first)
# second_row.push(Image.read("4.jpg").first)
# big_image.push(second_row.append(false))

#now we are saving the final image that is composed from 2 images by sepcify append with argument true meaning that each image will be on a separate row
big_image.append(true).write("qr/big_image.png")
