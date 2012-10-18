require 'open-uri'
require 'nokogiri'

html = Nokogiri::HTML(open("http://wiki.case.edu/Special:Imagelist?limit=5000&ilsearch=&title=Special%3AImagelist"))
td_link_things = html.css(".TablePager_col_links")
links = []
td_link_things.each do |t|
	links << "http://wiki.case.edu#{t.xpath("./a")[1].attributes['href'].value}"
end
links.each do |l|
	`wget #{l} -nd -P files`
end
