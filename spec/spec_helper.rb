require 'active_record'
require 'sqlite3'
require 'okubo'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)

ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :okubo_deck do |t|
    t.references  :user, :polymorphic => true
    t.timestamps
  end
  add_index :okubo_deck, [:user_id, :user_type]

  create_table :words do |t|
    t.string :kanji
    t.string :kana
    t.string :translation
    t.timestamps
  end

  create_table :users do |t|
    t.string :name
    t.timestamps
  end
end

class Word < ActiveRecord::Base
end

class User < ActiveRecord::Base
  has_deck :words
end