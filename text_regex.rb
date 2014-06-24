require 'pry'
require 'nokogiri'
require 'HTTParty'

text = HTTParty.get('https://code.wireshark.org/review/gitweb?p=wireshark.git;a=blob_plain;f=manuf;hb=HEAD')
#puts response.code
i=0
#binding.pry
text.each_line do | line|
	if /^(([0-9-A-F]){2}+[\\:]){2}+([0-9-A-F]{2})/.match(line)
		puts i
		i+=1
	end
	
end