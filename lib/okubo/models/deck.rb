module Okubo
  class Deck < ActiveRecord::Base
    self.table_name = "okubo_deck"
    belongs_to :user, :polymorphic => true
  end
end