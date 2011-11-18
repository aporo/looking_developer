class AddCountToCommitLog < ActiveRecord::Migration
  def change
    add_column :commit_logs, :count, :integer, :default => 0
  end
end
