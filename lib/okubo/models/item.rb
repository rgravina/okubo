module Okubo
  class Item < ActiveRecord::Base
    self.table_name = "okubo_items"
    belongs_to :deck
    belongs_to :source, :polymorphic => true
    scope :untested, :conditions => {:box => 0, :last_reviewed => nil}

    def right!
      self[:box] += 1
      self.last_reviewed = Time.now
      self.save!
    end
  end
end