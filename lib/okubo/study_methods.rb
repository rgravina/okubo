module Okubo
  module StudyMethods
    def add_deck
      Okubo::Deck.create!(:user_id => self.id, :user_type => self.class.name)
      self.class.send(:define_method, self.deck_name) do
        Okubo::Deck.first(:user_id => self.id, :user_type => self.class.name)
      end
    end
  end
end