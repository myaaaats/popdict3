# conding: utf-8
require "sinatra"
require "sinatra/json"
require "sinatra/reloader"

require "./model"

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
  configure :development do
    register Sinatra::Reloader
    enable :sessions
    use Rack::Session::Cookie, :path => '/'

  end


get '/secret' do
  not_authentication = authenticate
  return not_authentication if not_authentication

  'Welcome to a secret page, #{env['REMOTE_USER']}!'
end

  get '/login' do
    session[:foo] = Time.now
    session[:id] = session.id
    puts session[:foo]
    puts session[:id]
    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


  get '/dict/:word' do
  end

  get '/check/:word' do
    response = {}
    text = params["word"]
    text.chomp!
    text_downcase = text.gsub(/[\.,?!()*:;{}~=|'&%0123456789]/, '').downcase
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
