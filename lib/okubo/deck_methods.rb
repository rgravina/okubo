module Okubo
  module DeckMethods
    def deck
      Okubo::Deck.find_or_create_by_user_id_and_user_type(self.id, self.class.name)
    end

    def remove_deck
      deck = Okubo::Deck.first(:conditions => {:user_id => self.id, :user_type => self.class.name})
      deck.destroy
    end
  end
end