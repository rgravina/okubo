module Okubo
  class Deck < ActiveRecord::Base
    self.table_name = "okubo_decks"
    belongs_to :user, :polymorphic => true
    has_many :items, :class_name => "Okubo::Item", :dependent => :destroy
    
    def self.add_deck(user)
      create!(user)
    end

    def ==(other)
      if other.respond_to?(:items)
        self.items.map(&:source) == other.items
      else
        self.items.map(&:source) == other
      end
    end

    def <<(source)
      self.items << Okubo::Item.new(:deck => self, :source_id => source.id, :source_type => source.class.name)
    end

    def untested
      self.items.untested.map(&:source)
    end
  end
end