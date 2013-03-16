module Okubo
  class StudySession < ActiveRecord::Base
    self.table_name = "okubo_study_sessions"
    belongs_to :deck
    scope :completed, :conditions => ["completed_at is not null"]
    scope :active, :conditions => ["completed_at is null"]
  end
end