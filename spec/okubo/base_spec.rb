# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Okubo::Base do
  before(:each) do
    @word = Word.create!(:kanji => "日本語", :kana => "にほんご", :translation => "Japanese language")
  end

  context "Mixin" do
    describe "#has_deck_of" do
      it "should add a decks method"
    end
  end
end