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
      expect(@user.words.to_a).to eql([@word])
      expect(@user.words.count).to eql(1)
    end

    it "should start off in the untested stack" do
      expect(@user.words.untested).to eql([@word])
    end

    it "correct answer should move it up one stack" do
      @user.right_answer_for!(@word)
      expect(@user.words.untested).to eql([])
      expect(@user.words.box(1)).to eql([@word])
      expect(@user.words.known).to eql([@word])
    end

    it "incorrect answer should move it to the failed stack" do
      @user.wrong_answer_for!(@word)
      expect(@user.words.untested).to eql([])
      expect(@user.words.failed).to eql([@word])
      expect(@word.stats.times_wrong).to eql(1)
    end
  end

  context "Study schedule" do
    it "when untested, next study time should be nil" do
      expect(@word.stats.next_review).to be_nil
    end

    it "when correct, next study time should gradually increase" do
      Time.use_zone('UTC') do
        Timecop.freeze(Time.current) do
          @user.right_answer_for!(@word)
          stats = @word.stats
          expect(stats.next_review).to eq(stats.last_reviewed + 3.days)
          expect(stats.times_right).to eq(1)
          @user.right_answer_for!(@word)
          stats.reload
          expect(stats.next_review).to eq(stats.last_reviewed + 7.days)
          expect(stats.times_right).to eq(2)
          @user.right_answer_for!(@word)
          stats.reload
          expect(stats.next_review).to eq(stats.last_reviewed + 14.days)
          @user.right_answer_for!(@word)
          stats.reload
          expect(stats.next_review).to eq((stats.last_reviewed + 30.days))
          @user.right_answer_for!(@word)
          stats.reload
          expect(stats.next_review).to eq(stats.last_reviewed + 60.days)
          @user.right_answer_for!(@word)
          stats.reload
          expect(stats.next_review).to eq(stats.last_reviewed + 120.days)
          @user.right_answer_for!(@word)
          stats.reload
          expect(stats.next_review).to eq(stats.last_reviewed + 240.days)
        end
      end
    end

    it "words should expire and move from known to expired" do
      @user.right_answer_for!(@word)
      expect(@user.words.known).to eq([@word])
      Timecop.travel(4.days)
      expect(@user.words.known).to be_empty
      expect(@user.words.expired).to eq([@word])
      Timecop.return
    end
  end
end
