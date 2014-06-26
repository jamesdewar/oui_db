require 'pry'
require 'HTTParty'
require 'pp'
require 'Nokogiri'



class Search



	def initialize
   @text_mac_prefix = HTTParty.get('https://code.wireshark.org/review/gitweb?p=wireshark.git;a=blob_plain;f=manuf;hb=HEAD')
   response = HTTParty.get( 'http://www.macvendorlookup.com/vendormacs-xml-download')
   doc = Nokogiri::XML(response)
   @list_text_vendor_name = {}
   @list_text_vendor_detail = {}
   @list_prefix_xml = {}
   @items_mac_prefix_xml = doc.xpath("//xmlns:VendorMapping")
    @txt_detail = Array.new()
   search_text
   search_xml
   xml_to_txt

 end


 def search_text

  i=0
  @text_mac_prefix.each_line do | line|
   if /^(([0-9-A-F]){2}+[\\:]){2}+([0-9-A-F]{2})+\s/.match(line)
        @txt_detail[i] =  {"oui"=> line[/^(([0-9-A-F]){2}+[\\:]){2}+([0-9-A-F]{2})/], "short"=> line[/(?<=\t)\w+/],"long"=>line[/(?<=[#]).+/]}
				#@list_text_vendor_name[line[/^(([0-9-A-F]){2}+[\\:]){2}+([0-9-A-F]{2})/]] = line[/(?<=\t)\w+/]
				#@list_text_vendor_detail[line[/(?<=\t)\w+/]] = line[/(?<=[#]).+/]
        i+=1
		  end
		end
	end

	def search_xml
		@items_mac_prefix_xml.each do |element| 

			@list_prefix_xml[element["mac_prefix"]] = element["vendor_name"] 

		end
	end

  def xml_to_txt
    i=0
    @txt_detail.each do |element|

       @txt_detail[i]["xml_vendor_name"] = @list_prefix_xml[@txt_detail[i]["oui"]]
      i+=1
    end
    #@list_prefix_xml.reject { |element| @txt_detail[i]["oui"]  }
    j=0
    binding.pry
    #@list_prefix_xml.reject do |e|  e == @txt_detail[j]["oui"] j+=1 end 

  #  pp @txt_detail
  end



end


oui_update = Search.new