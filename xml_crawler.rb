require 'nokogiri'
require 'open-uri'
base_url = "http://wiki.case.edu"
html = Nokogiri::HTML(open("#{base_url}/Special:Allpages"))

link_pages = html.css(".allpageslist > tr").xpath("./td[1]/a").collect{|l| l['href']}
all_pages = []

link_pages.each do |link|
	page = Nokogiri::HTML(open("#{base_url}#{link}"))
	all_pages += page.css("#bodyContent").xpath("./table[2]").css("a").collect{|l| l['href']}
end

all_pages.each do |link|
	export_link = "#{base_url}/Special:Export#{link}"
	`wget #{export_link} -P xml`
end
