require 'rubygems'
require 'sequel'

DB = Sequel.sqlite('dictionary.sqlite3')


# Table操作
#----------------------------------------
def create_table
  DB.create_table :items do
    primary_key :item_id
    Text :word
    Text :mean
    Integer :level
  end


end


# CRUD操作(Create Read Update Delete)
#----------------------------------------

def find_by word
  DB[:items].filter(:word => word).select(:mean).all.first
end

def update item_id, word, mean, level

end

def create word, mean, level
  #
end

def delete item_id, word, mean, level
  #
end

