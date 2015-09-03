module Okubo
  class Item < ActiveRecord::Base
    self.table_name = "okubo_items"
    belongs_to :deck
    belongs_to :source, :polymorphic => true
    scope :untested, lambda{where(["box = ? and last_reviewed is null", 0])}
    scope :failed, lambda{where(["box = ? and last_reviewed is not null", 0])}
    scope :known, lambda{where(["box > ? and next_review > ?", 0, Time.now])}
    scope :expired, lambda{where(["box > ? and next_review <= ?", 0, Time.now])}

    DELAYS = [3, 7, 14, 30, 60, 120, 240]

    def right!
      self[:box] += 1
      self.times_right += 1
      self.last_reviewed = Time.now
      self.next_review = last_reviewed + DELAYS[[DELAYS.count, box].min-1].days
      self.save!
    end

    def wrong!
      self[:box] = 0
      self.times_wrong += 1
      self.last_reviewed = Time.now
      self.next_review = nil
      self.save!
    end
  end
end
