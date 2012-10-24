module Okubo
  module Base
    def self.included(klass)
      klass.extend ClassMethods
    end
  end
  
  module ClassMethods
    def has_deck_of(item)
    end
  end
end