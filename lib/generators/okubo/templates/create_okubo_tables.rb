class CreateOkuboTables < ActiveRecord::Migration
  def self.up
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
      t.timestamp   :next_review
      t.timestamps
    end
    add_index :okubo_items, [:source_id, :source_type]
  end

  def self.down
    drop_table :okubo_decks
    drop_table :okubo_items
  end
end
