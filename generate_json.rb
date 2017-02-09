require 'json'
codes = ['1234abCD', '1234abCE','1234abCF', '1234abCG'].map{|code| {'shortcode': code} }
File.open("qr/codes.json", "w") { |f| f.write(codes.to_json) }
