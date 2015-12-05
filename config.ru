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

  end

  # Index のページを表示する
  get '/' do
    if ! session[:foo]
      puts session.to_s
      erb :notlogin

    else
      erb :dict

    end

  end

  configure :development do
    $logger = Logger.new(STDOUT)
  end

end


run PopDict