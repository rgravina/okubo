require 'okubo/base'
require 'okubo/models/deck'
require "okubo/version"

ActiveRecord::Base.send(:include, Okubo::Base)