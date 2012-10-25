require 'okubo/base'
require 'okubo/study_methods'
require 'okubo/models/deck'
require 'okubo/models/item'
require "okubo/version"

ActiveRecord::Base.send(:include, Okubo::Base)