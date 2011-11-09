class AddCommitCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :commit_count, :integer, :default => 0
  end
end
