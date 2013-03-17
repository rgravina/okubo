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

    it "should tell you what word was last added to the deck" do
      @user.words << @word
      @user.words.last.should == @word
    end
  end

  context "Reviewing" do
    it "should return an array of words to review" do
      @user.words << @word
      @user.words << Word.create!(:kanji => "日本語1", :kana => "にほんご1", :translation => "Japanese language")
      @user.words.known.count.should == 0
      (@user.words.untested + @user.words.failed + @user.words.expired).sort.should == @user.words.review.sort
    end

    it "marking words right/wrong" do
      @user.words << @word
      @user.words << Word.create!(:kanji => "日本語1", :kana => "にほんご1", :translation => "Japanese language")
      @user.words.count.should == 2
      @user.words.review.count.should == 2
      @user.words.review.each_with_index do |word, index|
        index.even? ? @user.right_answer_for!(word) : @user.wrong_answer_for!(word)
      end
      @user.words.review.count.should == 1
    end

    it "should allow you to get one word only" do
      @user.words << @word
      @user.words << Word.create!(:kanji => "日本語1", :kana => "にほんご1", :translation => "Japanese language")
      @user.words.known.count.should == 0
      word = @user.words.next
      @user.words.untested.include?(word).should be_true
      @user.right_answer_for!(word)
      word = @user.words.next
      @user.words.untested.include?(word).should be_true
      @user.right_answer_for!(word)
      @user.words.next.should be_nil
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