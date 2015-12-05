# conding: utf-8
require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'

require './model'
require './api/api'

Encoding.default_external = 'utf-8'

$stdout.sync = true

map('/api') { run Api }
class PopDict < Sinatra::Base
  set :views, settings.root + '/html'
  set :public_folder, File.dirname(__FILE__) + '/static'

  configure :development do
    register Sinatra::Reloader
    enable :sessions
    use Rack::Session::Cookie, :path => '/'
  end

  # Index のページを表示する
  get '/' do
    if ! session.has_key?('id')
      erb :notlogin

    else
      erb :dict, :locals => {:name => session[:id]}
    end

  end

  configure :development do
    $logger = Logger.new(STDOUT)
  end

end


run PopDict