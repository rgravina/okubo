class AddOkuboItemAnswerCounts < ActiveRecord::Migration
  def self.up
    add_column :okubo_items, :times_right, :integer, :default => 0
    add_column :okubo_items, :times_wrong, :integer, :default => 0
  end

  def self.down
    remove_column :okubo_items, :times_right
    remove_column :okubo_items, :times_wrong
  end
end
