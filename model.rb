require 'rubygems'
require 'sequel'

DB = Sequel.sqlite('dictionary.sqlite3')


def find_by word
  DB[:items].filter(:word => word).select(:mean).all.first
end