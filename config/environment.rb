require 'rest-client'
require 'json'
require 'bundler'
require 'cities'
require 'countries/global'
require 'pry'
require 'pp'
require 'paint'

Cities.data_path = 'db/cities'

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil
