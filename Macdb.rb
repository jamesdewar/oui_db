
require 'HTTParty'
require 'nokogiri'
require 'pry'
require 'pp'


response = HTTParty.get( 'http://www.macvendorlookup.com/vendormacs-xml-download')
doc = Nokogiri::XML(response)

items_mac_prefix = doc.xpath("//xmlns:VendorMapping")
list = {}

items_mac_prefix.each do |element| 
	
	list[element["mac_prefix"]] = element["vendor_name"]  
end
pp list
#binding.pry



