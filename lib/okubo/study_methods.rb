module Okubo
  module StudyMethods
    def add_deck
      Okubo::Deck.create!(:user_id => self.id, :user_type => self.class.name)
      self.class.send(:define_method, self.deck_name) do
        deck = Okubo::Deck.first(:conditions => {:user_id => self.id, :user_type => self.class.name})
        deck.items
      end
    end
  end
end