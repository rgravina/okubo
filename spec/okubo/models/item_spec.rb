# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Okubo::Item do
  before(:each) do
    @word = Word.create!(:kanji => "日本語", :kana => "にほんご", :translation => "Japanese language")
    @user = User.create!(:name => "Robert")
    @user.words << @word
  end

  context "Leitner box movement" do
    it "should start off in the untested stack" do
      @user.words.untested.should == [@word]
    end

    it "correct answer should move it up one stack" do
      @user.right_answer_for!(@word)
      @user.words.untested.should == []
      @user.words.box(1).should == [@word]
    end

    it "incorrect answer should move it to the failed stack"
  end

  context "Study schedule" do
    it "when untested, next study time should be nil"
    it "when correct for the first time, next study time should be in one day"
  end
end