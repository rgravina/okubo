module Okubo
  module DeckMethods
    def deck
      d = Okubo::Deck.find_or_create_by_user_id_and_user_type(self.id, self.class.name)
      d.source_class.module_eval do 
        def stats
         Okubo::Item.first(:conditions => {:source_id => self.id, :source_type => self.class.name})
        end
      end
      d
    end

    def remove_deck
      deck = Okubo::Deck.first(:conditions => {:user_id => self.id, :user_type => self.class.name})
      deck.destroy
    end
  end
end