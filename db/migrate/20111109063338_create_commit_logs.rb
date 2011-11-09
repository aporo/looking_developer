class CreateCommitLogs < ActiveRecord::Migration
  def change
    create_table :commit_logs do |t|
      t.timestamp :commit_at
      t.integer :user_id
      t.integer :type_id

      t.timestamps
    end
  end
end
