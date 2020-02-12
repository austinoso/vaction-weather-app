# require 'rest-client'
require 'JSON'
require 'bundler'
require 'cities'
require 'countries/global'

Cities.data_path = 'db/cities'

ISO3166.configure do |config|
    config.locales = [:af, :am, :ar, :as, :az, :be, :bg, :bn, :br, :bs, :ca, :cs, :cy, :da, :de, :dz, :el, :en, :eo, :es, :et, :eu, :fa, :fi, :fo, :fr, :ga, :gl, :gu, :he, :hi, :hr, :hu, :hy, :ia, :id, :is, :it, :ja, :ka, :kk, :km, :kn, :ko, :ku, :lt, :lv, :mi, :mk, :ml, :mn, :mr, :ms, :mt, :nb, :ne, :nl, :nn, :oc, :or, :pa, :pl, :ps, :pt, :ro, :ru, :rw, :si, :sk, :sl, :so, :sq, :sr, :sv, :sw, :ta, :te, :th, :ti, :tk, :tl, :tr, :tt, :ug, :uk, :ve, :vi, :wa, :wo, :xh, :zh, :zu]
end

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'