Okubo
=====

Okubo is a simple spaced-repetition gem for learning words and definitions in a foreign language.

TODO: implement it :)

Examples
--------
  # add words and definitions to your database
  o = Okubo.new
  o.add_word("日本語", "にほんご", "Japanese (language)")

  #....
  o.words.count # 1
  # study those needing review
  o.pending_words.each do |word|
    puts word
  end
