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

    it "should be an iterator of words" do
      @user.words << @word
      a = []
      @user.words.each do |w|
        a << w
      end
      a.should == [@word]
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

  context "Reviewing" do
    it "should choose a random word from untested, failed or pending" do
      @user.words << @word
      @user.words.review_next.should == @word
      word = Word.create!(:kanji => "日本語", :kana => "にほんご", :translation => "Japanese language")
      @user.words << word
      [@word, word].include?(@user.words.review_next).should be_true
      @user.right_answer_for!(@word)
      [word].include?(@user.words.review_next).should be_true
      @user.wrong_answer_for!(@word)
      @user.right_answer_for!(word)
      [@word].include?(@user.words.review_next).should be_true
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