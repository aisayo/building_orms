require 'bundler'
Bundler.require


# create a database/make it available connecting and executing upon it

DB = {:conn => SQLite3::Database.new("db/tweets.db")}
# DB[:conn].execute

#DB = Sqlite3::Database.new("db/tweets.db")
# DB.execute

DB[:conn].results_as_hash = true 

require_relative '../lib/tweet'
require_relative '../db/seed'


Tweet.create_table

