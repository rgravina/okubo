# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Okubo::DeckMethods do
  before(:each) do
    @word = Word.create!(:kanji => "日本語", :kana => "にほんご", :translation => "Japanese language")
    @user = User.create!(:name => "Robert")
  end

  context "Decks" do
    describe "#words" do
      it "should return an empty list when empty" do
        @user.words.should == []
      end

      it "should allow access of word stats" do
        @user.words << @word
        @word.stats
      end
    end
  end
end