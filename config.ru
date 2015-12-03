# conding: utf-8
require 'rubygems'
require 'sinatra/base'

require './model'
require './api/api'

Encoding.default_external = 'utf-8'

$stdout.sync = true

map('/api') { run Api }
class PopDict < Sinatra::Base
  set :views, settings.root + '/html'
  set :public_folder, File.dirname(__FILE__) + '/static'


  # Index のページを表示する
  get '/' do
    erb :dict
  end
  configure :development do
    $logger = Logger.new(STDOUT)
  end

end


run PopDict