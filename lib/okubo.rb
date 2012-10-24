require 'okubo/base'
require "okubo/version"

ActiveRecord::Base.send(:include, Okubo::Base)