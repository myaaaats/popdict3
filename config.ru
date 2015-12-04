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



  # Index のページを表示する
  get '/' do
    # html/dict.erb を返す。
    # パラメーター渡すと、それ埋め込んだHTMLを生成してくれる
    # （今回は特に使ってない）
    erb :dict
  end

  configure :development do
    $logger = Logger.new(STDOUT)
  end

end


run PopDict