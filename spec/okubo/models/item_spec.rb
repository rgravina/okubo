# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Okubo::Item do
  before(:each) do
    @word = Word.create!(:kanji => "日本語", :kana => "にほんご", :translation => "Japanese language")
    @user = User.create!(:name => "Robert")
    @user.words << @word
  end

  context "Leitner box movement" do
    it "should present a list of all words" do
      @user.words.should == [@word]
      @user.words.count.should == 1
    end

    it "should start off in the untested stack" do
      @user.words.untested.should == [@word]
    end

    it "correct answer should move it up one stack" do
      @user.right_answer_for!(@word)
      @user.words.untested.should == []
      @user.words.box(1).should == [@word]
      @user.words.known.should == [@word]
    end

    it "incorrect answer should move it to the failed stack" do
      @user.wrong_answer_for!(@word)
      @user.words.untested.should == []
      @user.words.failed.should == [@word]
      stats = Okubo::Item.first(:conditions => {:source_id => @word.id, :source_type => @word.class.name})
      stats.times_wrong.should == 1
    end
  end

  context "Study schedule" do
    it "when untested, next study time should be nil" do
      stats = Okubo::Item.first(:conditions => {:source_id => @word.id, :source_type => @word.class.name})
      stats.next_review.should be_nil
    end

    it "when correct, next study time should gradually increase" do
      Timecop.freeze
      @user.right_answer_for!(@word)
      stats = Okubo::Item.first(:conditions => {:source_id => @word.id, :source_type => @word.class.name})
      stats.next_review.should == Time.now + 3.days
      stats.times_right.should == 1
      @user.right_answer_for!(@word)
      stats.reload
      stats.next_review.should == Time.now + 7.days
      stats.times_right.should == 2
      @user.right_answer_for!(@word)
      stats.reload
      stats.next_review.should == Time.now + 14.days
      @user.right_answer_for!(@word)
      stats.reload
      stats.next_review.should == Time.now + 30.days
      @user.right_answer_for!(@word)
      stats.reload
      stats.next_review.should == Time.now + 60.days
      @user.right_answer_for!(@word)
      stats.reload
      stats.next_review.should == Time.now + 120.days
      @user.right_answer_for!(@word)
      stats.reload
      stats.next_review.should == Time.now + 240.days
      Timecop.return
    end

    it "words should expire and move from known to expired" do
      @user.right_answer_for!(@word)
      @user.words.known.should == [@word]
      Timecop.travel(4.days)
      @user.words.known.should == []
      @user.words.expired.should == [@word]
      Timecop.return
    end
  end
end