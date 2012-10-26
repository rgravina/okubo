# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Okubo::StudyMethods do
  before(:each) do
    @word = Word.create!(:kanji => "日本語", :kana => "にほんご", :translation => "Japanese language")
    @user = User.create!(:name => "Robert")
  end

  context "Decks" do
    describe "#words" do
      it "should return an empty list when empty" do
        @user.words.should == []
      end
    end
  end
end