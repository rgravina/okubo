class CreateOkuboStudySessionTables < ActiveRecord::Migration
  def self.up
    create_table :okubo_study_sessions do |t|
      t.references  :deck
      t.integer     :right, :default => 0
      t.integer     :wrong, :default => 0
      t.timestamp   :completed_at
      t.timestamps
    end

    create_table :okubo_study_session_items do |t|
      t.references  :study_session
      t.references  :item
      t.timestamp   :reviewed_at
      t.boolean     :correct
    end
  end

  def self.down
    drop_table :okubo_study_sessions
    drop_table :okubo_study_session_items
  end
end
