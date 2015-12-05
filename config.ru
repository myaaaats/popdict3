# conding: utf-8
require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'
require 'pp'

require './model'
require './index'
require './api/api'

Encoding.default_external = 'utf-8'

$stdout.sync = true


map('/api') { run Api }
map('/') { run PopDict }


run PopDict