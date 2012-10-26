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
        source_class.find(self.items.pluck(:source_id)) == other.items
      else
        source_class.find(self.items.pluck(:source_id)) == other
      end
    end

    def <<(source)
      self.items << Okubo::Item.new(:deck => self, :source_id => source.id, :source_type => source.class.name)
    end

    def untested
      source_class.find(self.items.untested.pluck(:source_id))
    end

    def source_class
      user.deck_name.to_s.singularize.titleize.constantize
    end

    def box(number)
      source_class.find(self.items.where(:box =>  number).pluck(:source_id))
    end
  end
end