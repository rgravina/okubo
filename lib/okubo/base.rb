module Okubo
  module Base
    def self.included(klass)
      klass.extend ClassMethods
    end
  end
  
  module ClassMethods
    def has_deck(name)
      define_method(:deck_name){name}
      include Okubo::DeckMethods
      include Okubo::ItemMethods
      define_method(name){self.deck}
      after_destroy(:remove_deck)
    end
  end
end