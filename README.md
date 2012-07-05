Okubo
=====

Okubo is a simple spaced-repitition gem for learning words and definitions in a foreign language.

Examples
--------
  # add words and definitons to your database
  o = Okubo.new
  o.add_word("日本語", "にほんご", "Japanese (language)")

  #....

  # study those needing review
  o.pending_words.each do |word|
    puts word
  end


Bon Apetit!

