require 'bundler/setup'
Bundler.require

ENV['MONGOID_ENV'] = 'development'

Mongoid.load!("config/mongoid.yml")
