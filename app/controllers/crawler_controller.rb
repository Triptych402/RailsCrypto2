require 'open-uri'
class CrawlerController < ApplicationController
  def index
		url = "https://finance.naver.com/marketindex/?tabSel=exchange#tab_section"
		doc = Nokogiri::HTML(open(url),nil, 'euc-kr')
		currency = doc.css('div.head_info.point_dn > span.value')
		@new_currency = currency.map { |cur| cur.text }
		currency_name = doc.css('h3.h_lst')
		@new_currency_name = currency_name.map { |cur_n| cur_n.text }
  end
end
