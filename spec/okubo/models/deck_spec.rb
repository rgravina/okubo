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

    it "should raise an error if a duplicate word exists" do
      @user.words << @word
      @user.words.should == [@word]
      expect{@user.words << @word}.to raise_error(ArgumentError)
    end

    it "should remove words from the word list (but not the model itself)" do
      @user.words.delete(@word)
      @user.words.include?(@word).should be_false
      @word.destroyed?.should be_false
    end
  end

  context "Cleaning up" do
    it "should delete itself and all item information when the source model is deleted" do
      deck = @user.words
      @user.destroy
      Okubo::Deck.exists?(:user_id => @user.id).should be_false
      Okubo::Item.exists?(:deck_id => deck.id).should be_false
      @word.destroyed?.should be_false
    end
  end
end