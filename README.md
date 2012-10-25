Okubo
=====

Okubo is a simple spaced-repetition system which you can associate with Active Record models to be learned
(words in a foreign language, capital cities of the world etc.) and users in your system, Users study these 
words, and as they mark these attempts "right" or "wrong", Okubo will determine when they should be reviewed
next.

Okubo schedules items into boxes and uses this to determine the next study time for an item, based on the [Leitner System](http://en.wikipedia.org/wiki/Leitner_system).
In the future it may support other popular algorithms, such as the Supermemo 2 algorithm (SM2).

Installation
------------

Coming soon ...

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

Thanks!
-------

* [activerecord-reputation-system](https://github.com/twitter/activerecord-reputation-system/) - for providing the design and implementation from which this gem is based.
* [randym](https://github.com/randym/) - for enouraging me work on this gem in the first place.
* [Tokyo Rails](http://www.tokyorails.com/) - for providing collaboration evenings where this gem was worked on.
* [Reviewing the Kanji](http://kanji.koohii.com/) - for providing a great visual representation of the Leitner system and names for the stacks.

Copyright and License
---------------------
Okubo © 2012 by Robert Gravina. Okubo is licensed under the MIT license. Please see the LICENSE document for more information.