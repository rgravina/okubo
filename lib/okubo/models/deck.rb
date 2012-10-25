module Okubo
  class Deck < ActiveRecord::Base
    self.table_name = "okubo_deck"
    belongs_to :user, :polymorphic => true
    
    def self.add_deck(user)
      create!(user)
    end
  end
end