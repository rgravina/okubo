# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Okubo::Deck do
  before(:each) do
    @word = Word.create!(:kanji => "日本語", :kana => "にほんご", :translation => "Japanese language")
    @user = User.create!(:name => "Robert")
  end

  context "Leitner box movement" do
    it "should start off in the untested stack"
    it "correct answer should move it up one stack"
    it "incorrect answer should move it to the failed stack"
  end

  context "Study schedule" do
    it "when untested, next study time should be nil"
    it "when correct for the first time, next study time should be in one day"
  end
end