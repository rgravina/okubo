# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Okubo::Deck do
  before(:each) do
    @word = Word.create!(:kanji => "日本語", :kana => "にほんご", :translation => "Japanese language")
    @user = User.create!(:name => "Robert")
  end

  context "Managing word lists" do
    it "should add words to the word list" do
      @user.words << @word
      @user.words.should == [@word]
    end
    it "should raise an error if a duplicate word exists"
    it "should remove words from the word list (but not the model itself)"
  end

  context "Browsing word lists" do
    it "should allow user to iterate through all words"
    it "should allow user to iterate words scheduled for review only"
  end

  context "Cleaning up" do
    it "should delete itself and all item information when the source model is deleted"
  end
end