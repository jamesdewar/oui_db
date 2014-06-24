require 'pry'
require 'nokogiri'
require 'HTTParty'

#response = HTTParty.get('https://code.wireshark.org/review/gitweb?p=wireshark.git;a=blob_plain;f=manuf;hb=HEAD')
#puts response.code
text = File.read('test_regex.txt')
i=0
#binding.pry
colon = ":"
text.each_line do | line|
	if /^[0-9-A-F]+[0-9-A-F]+[\\:]+[0-9-A-F]+[0-9-A-F]+[\\:]+[0-9-A-F]+[0-9-A-F]/.match(line)
		puts i
		i+=1
	end
	
end