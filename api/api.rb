# conding: utf-8
require "sinatra"
require "sinatra/json"
require "sinatra/reloader"

require "./model"

class Api < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/dict/:word' do
  end

  get '/check/:word' do
    response = {}
    text = params["word"]
    text.chomp!
    text_downcase = text.gsub(/[\.,?!()*:;{}~=|'&%0123456789]/,'').downcase
    words = text_downcase.split(" ")
    words.uniq!

    # db に繰り返し問い合わせ
    for word in words do

      entry = find_by(word)
      if not entry.nil?
        puts entry
        puts entry[:mean]
        response[word] = entry[:mean]
      end
    end

    json response
  end


  get '/sequence' do
    "test"
  end

  $logger = Logger.new(STDOUT)

end