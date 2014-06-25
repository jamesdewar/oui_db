require 'pry'
require 'HTTParty'
require 'pp'

text = HTTParty.get('https://code.wireshark.org/review/gitweb?p=wireshark.git;a=blob_plain;f=manuf;hb=HEAD')
#puts response.code
i=0
#binding.pry
list_text_vendor_name = {}
list_text_vendor_detail = {}

text.each_line do | line|
	if /^(([0-9-A-F]){2}+[\\:]){2}+([0-9-A-F]{2})+\s/.match(line)
		list_text_vendor_name [line[/^(([0-9-A-F]){2}+[\\:]){2}+([0-9-A-F]{2})/]] = line[/(?<=\t)\w+/]
		list_text_vendor_detail[line[/(?<=\t)\w+/]] = line[/(?<=[#]).+/]
	end
end

pp list_text_vendor_name
pp list_text_vendor_detail