require 'json'
codes = ['1234abCD', '1234abCE'].map{|code| {'qrCode': "http://www.slingshot.company?s=#{code}", 'shortcode': code} }
File.open("qr/codes.json", "w") { |f| f.write(codes.to_json) }
