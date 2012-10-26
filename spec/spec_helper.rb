require 'active_record'
require 'sqlite3'
require 'okubo'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)

ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  # Okubo tables
  create_table :okubo_decks do |t|
    t.references  :user, :polymorphic => true
    t.timestamps
  end
  add_index :okubo_decks, [:user_id, :user_type]

  create_table :okubo_items do |t|
    t.references  :deck
    t.references  :source, :polymorphic => true
    t.integer     :box, :default => 0
    t.timestamp   :last_reviewed
    t.timestamps
  end
  add_index :okubo_items, [:source_id, :source_type]

  # Test application tables
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

# Test application models
class Word < ActiveRecord::Base
end

class User < ActiveRecord::Base
  has_deck :words
end