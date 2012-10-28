Okubo [![Build Status](https://travis-ci.org/rgravina/okubo.png)](https://travis-ci.org/rgravina/okubo) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/rgravina/okubo)
=====

Okubo is a simple spaced-repetition system which you can associate with Active Record models to be learned
(words in a foreign language, capital cities of the world etc.) and users in your system, Users study these 
words, and as they mark these attempts "right" or "wrong", Okubo will determine when they should be reviewed
next.

Okubo schedules items into boxes and uses this to determine the next study time for an item, based on the [Leitner System](http://en.wikipedia.org/wiki/Leitner_system).
In the future it may support other popular algorithms, such as the Supermemo 2 algorithm (SM2).

Installation
------------

Add to Gemfile (will put on rubygems once at 0.1):

```
gem 'okubo', :git => "git://github.com/rgravina/okubo.git"
```

Run:

```
bundle install
rails generate okubo
rake db:migrate
```

Quick Start
-----------

Imagine you have an application allowing your users to study words in a foreign language. You can set this up as follows:

```ruby
class Word < ActiveRecord::Base
end

class User < ActiveRecord::Base
  has_deck :words
end

user = User.create!(:name => "Robert")
word = Word.create!(:kanji => "日本語", :kana => "にほんご", :translation => "Japanese language")
```

This gives your user a deck of words to study, initially empty:

```ruby
user.words #=> []
```

Adding words to the deck adds it to the word list. It also belongs to the 'untested' stack:

```ruby
user.words << word
user.words #=> [word]
user.words.untested #=> [word]
```

These words can be studied immediately. Answering a word correctly moves it out of the 'untested' stack
and into your list of 'known' words.

```ruby
user.right_answer_for!(word)
user.words.untested #=> []
user.words.known #=> [word]
```

As time passes, words 'expire' and require you to review them to ensure you still remember them:

```ruby
# Three days later...
user.words.known #=> []
user.words.expired #=> [word]
```

Answering a word correcly several times in a row results in the word taking longer to 'expire'.
This spaced repetition helps ensure the word stays in your long term memory without needless repetition.

```ruby
user.right_answer_for!(word)
# One week later...
user.words.expired #=> [word]
user.right_answer_for!(word)
# Two weeks later...
user.words.expired #=> [word]
user.right_answer_for!(word)
# One month later...
user.words.expired #=> [word]
```

Finally, answering a word incorrectly moves it into the 'failed' stack. The word can then be
studied at any time (similar to words in the 'untested' stack) which puts it back in the review
cycle.

```ruby
user.wrong_answer_for!(word)
user.words.failed #=> [word]
user.right_answer_for!(word)
user.words.failed #=> []
user.words.known #=> [word]
# Three days later...
user.words.known #=> []
user.words.expired #=> [word]
```

Thanks!
-------

* [activerecord-reputation-system](https://github.com/twitter/activerecord-reputation-system/) - for providing the design and implementation from which this gem is based.
* [randym](https://github.com/randym/) - for enouraging me work on this gem in the first place.
* [Tokyo Rails](http://www.tokyorails.com/) - for providing collaboration evenings where this gem was worked on.
* [Reviewing the Kanji](http://kanji.koohii.com/) - for providing a great visual representation and implementation of the Leitner system.

Copyright and License
---------------------
Okubo © 2012 by Robert Gravina. Okubo is licensed under the MIT license. Please see the LICENSE document for more information.