module Okubo
  module DeckMethods
    def add_deck
      d = Okubo::Deck.create!(:user_id => self.id, :user_type => self.class.name)
      self.class.send(:define_method, self.deck_name) do
        Okubo::Deck.first(:conditions => {:user_id => self.id, :user_type => self.class.name})
      end
      d.source_class.send(:define_method, :stats) do
        Okubo::Item.first(:conditions => {:source_id => self.id, :source_type => self.class.name})
      end
    end

    def deck
      Okubo::Deck.first(:conditions => {:user_id => self.id, :user_type => self.class.name})
    end

    def remove_deck
      deck = Okubo::Deck.first(:conditions => {:user_id => self.id, :user_type => self.class.name})
      deck.destroy
    end
  end
end