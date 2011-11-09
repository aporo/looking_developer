class CreateLookingTypes < ActiveRecord::Migration
  def change
    create_table :looking_types do |t|
      t.integer :user_id
      t.integer :type_id

      t.timestamps
    end
  end
end
