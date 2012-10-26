module Okubo
  class Item < ActiveRecord::Base
    self.table_name = "okubo_items"
    belongs_to :deck
    belongs_to :source, :polymorphic => true
    scope :untested, :conditions => {:box => 0, :last_reviewed => nil}
    scope :failed, :conditions => ["box = ? and last_reviewed is not null", 0]
    DELAYS = [3, 7, 14, 30, 60, 120, 240]
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

    def next_review_time
      return nil unless last_reviewed
      last_reviewed + DELAYS[[DELAYS.count, box].min-1].days
    end
  end
end