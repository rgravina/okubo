require 'active_record'
require 'sqlite3'
require 'okubo'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)

ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :okubu_items do |t|
    t.references  :item, :polymorphic => true
    t.integer     :right, :default => 0
    t.integer     :wrong, :default => 0
    t.integer     :box, :default => 0
    t.timestamps
  end
  add_index :okubu_items, [:item_id, :item_type]

  create_table :words do |t|
    t.string :kanji
    t.string :kana
    t.string :translation
    t.timestamps
  end
end

class Word < ActiveRecord::Base
end