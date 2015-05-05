require 'active_record'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
ActiveRecord::Migration.verbose = false

load File.dirname(__FILE__) + '/schema.rb'
