require 'active_record'
require 'sqlite3'
require 'okubo'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)
