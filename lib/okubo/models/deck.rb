module Okubo
  class Deck < ActiveRecord::Base
    self.table_name = "okubo_decks"
    belongs_to :user, :polymorphic => true
    has_many :items
    
    def self.add_deck(user)
      create!(user)
    end
  end
end