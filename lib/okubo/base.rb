module Okubo
  module Base
    def self.included(klass)
      klass.extend ClassMethods
    end
  end
  
  module ClassMethods
    def has_study_schedule
    end
  end
end