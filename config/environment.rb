# require 'rest-client'
require 'JSON'
require 'bundler'
require 'cities'
require 'countries/global'

Cities.data_path = 'db/cities'

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'