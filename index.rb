# conding: utf-8
require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'
require 'pp'

require 'sinatra/cookies'

class PopDict < Sinatra::Base
  helpers Sinatra::Cookies

  set :views, settings.root + '/html'
  set :public_folder, File.dirname(__FILE__) + '/static'

  configure :development do
    register Sinatra::Reloader
    enable :sessions
    use Rack::Session::Cookie, :path => '/'

  end

  # Index のページを表示する
  get '/' do
    pp cookies
    pp session
    if ! session.has_key?('id')
      erb :notlogin

    else
      erb :dict, :locals => {:name => cookies[:id]}
    end

  end

  configure :development do
    $logger = Logger.new(STDOUT)
  end

end

