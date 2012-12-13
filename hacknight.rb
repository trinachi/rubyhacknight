require 'sinatra'
require 'open-uri'
require 'nokogiri'
require 'wordnik'
require './env'

Wordnik.configure do |config|
  config.api_key = ENV['wordnik_api_key']
end

get '/:word' do
  new_word = Nokogiri::HTML(open("http://spell.ockham.org/?word=#{params[:word]}&dictionary=earth"))
  suggested_spellings = new_word.xpath('//spell/spellings/spelling').children.map(&:to_s)
  definitions = Wordnik.word.get_definitions(suggested_spellings.first)
  body = ''
  body << "<ul>"
  suggested_spellings.each do |word|
    body << "<li>"
    body << word
    body << "</li>"
  end
  body << "</ul>"
  body << "<p>"
  body << definitions.first["text"].to_s
  body << "</p>"
end

get '/' do
  'hello world'
end