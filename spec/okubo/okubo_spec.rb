require 'spec_helper'

describe Okubo do
  describe "adding words" do
    it "should accept a kanji word, kana, and English translation and add to the store"
    it "should accept kana-only words"
    it "should raise an error if a duplicate word exists"
  end

  describe "retrieving words" do
    it "should allow user to iterate through all words"
    it "should allow user to iterate words scheduled for review only"
  end

  describe "scheduling words" do
    it "should move correct words one box forward"
    it "should move incorrect words to box zero"
    it "should return next study data based on word box"
  end

  describe "remembering words" do
    it "should mark a correct word as correct"
    it "should mark a wrong word as wrong"
  end
end