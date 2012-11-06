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

From here you can add words, and record attempts to guess the word as right or wrong. Various scopes exist to allow you to display counts or lists to the user:

```ruby
# Initally adding a word
user.words << word
user.words #=> [word]
user.words.untested #=> [word]

# Guessing a word correctly
user.right_answer_for!(word)
user.words.known #=> [word]

# Guessing a word incorrectly
user.wrong_answer_for!(word)
user.words.failed #=> [word]
```
As time passes, words need to be reviewed to keep them fresh in memory:

```ruby
# Three days later...
user.words.known #=> []
user.words.expired #=> [word]
```

Guessing a word correcly several times in a row results in the word taking longer to 'expire'. This is the heart of a spaced repetiton system.

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

Reviewing
---------

In addition to an 'expired' scope, Okubo provides a suggested reviewing sequece. A word is randomly chosen from untested words first, then if all have been studied, from failed, and finally expired. If no words remain to be studied, nil is returned:

```ruby
user.words.review_next #=> word
user.right_answer_for!(word)
# ... continuing until all untested, failed, and expired words have been guessed correctly.
user.words.review_next = nil
```

Examples
--------

[Chuhi](https://github.com/rgravina/chihi) is a Rails app which uses Okubo to schedule words. Have a look at the project source for real world usage. You can also [use the app online](http://chuhi.herokuapp.com/)!

Thanks!
-------

* [activerecord-reputation-system](https://github.com/twitter/activerecord-reputation-system/) - for providing the design and implementation from which this gem is based.
* [randym](https://github.com/randym/) - for enouraging me work on this gem in the first place.
* [Tokyo Rails](http://www.tokyorails.com/) - for providing collaboration evenings where this gem was worked on.
* [Reviewing the Kanji](http://kanji.koohii.com/) - for providing a great visual representation and implementation of the Leitner system.

Copyright and License
---------------------
Okubo © 2012 by Robert Gravina. Okubo is licensed under the MIT license. Please see the LICENSE document for more information.