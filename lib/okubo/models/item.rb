module Okubo
  class Item < ActiveRecord::Base
    self.table_name = "okubo_items"
    belongs_to :deck
    belongs_to :source, :polymorphic => true
    scope :untested, :conditions => {:box => 0, :last_reviewed => nil}
    scope :failed, :conditions => ["box = ? and last_reviewed is not null", 0]

    def right!
      self[:box] += 1
      self.last_reviewed = Time.now
      self.save!
    end

    def wrong!
      self[:box] = 0
      self.last_reviewed = Time.now
      self.save!
    end
  end
end