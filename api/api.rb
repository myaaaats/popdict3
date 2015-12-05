# conding: utf-8
require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'sinatra/cookies'

require 'pp'

require './model'

require 'sinatra'

helpers do
  def authenticate
    auth = Rack::Auth::Basic.new(Proc.new {}) do |username, password|
      username = 'test' && password = 'test'
    end
    return auth.call(request.env)
  end
end

class Api < Sinatra::Base
  helpers Sinatra::Cookies

  configure :development do
    register Sinatra::Reloader
    set :sessions, true
    use Rack::Session::Cookie,
        :path => '/',
        :secret => 'change'
  end

  post '/login' do
    pp params
    pp session
    if params.has_key?('name')
      # ToDo : implement authentication method
      name = params[:name]
      session[:id] = name
      cookies[:name] = name
    end
    pp session
    redirect '/'
  end

  get '/logout' do
    session.clear
    pp session
    redirect '/'
  end


  get '/dict/:word' do
  end

  get '/check/:word' do
    response = {}
    text = params['word']
    text.chomp!
    text_downcase = text.gsub(/[\.,?!()*:;{}~=|'&%0123456789]/, '').downcase
    words = text_downcase.split(' ')
    words.uniq!

    # db に繰り返し問い合わせ
    for word in words do

      entry = find_by(word)
      if not entry.nil?
        response[word] = entry[:mean]
      end
    end

    json response
  end

  post '/track' do
    puts "#{cookies[:name]} mouseover #{params[:word]}"
  end

  get '/sequence' do
    'test'
  end
end
