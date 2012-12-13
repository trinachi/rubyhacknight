require 'sinatra'
require 'open-uri'
require 'nokogiri'

get '/:word' do
  new_word = Nokogiri::HTML(open("http://spell.ockham.org/?word=#{params[:word]}"))
  body = ''
  body << "<ul>"
  new_word.xpath('//spell/spellings/spelling').children.map(&:to_s).each do |word|
    body << "<li>"
    body << word
    body << "</li>"
  end
  return body << "</ul>"
end

get '/' do
  'hello world'
end

