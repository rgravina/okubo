# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Okubo::StudySession do
  before(:each) do
    @word = Word.create!(:kanji => "日本語", :kana => "にほんご", :translation => "Japanese language")
    @user = User.create!(:name => "Robert")
    @user.words << @word
  end

  context "Creating study sessions" do
    it "should create sessions with all words by default"
    it "should allow passing a limiter to set size"
    it "should save the study session"
  end

  context "Progress" do
    it "progress should increase every time a answer is given"
    it "progress should increase every time a answer is given"
  end

  context "Immutability" do
    it "changes to the deck should not effect study session set"
  end
end