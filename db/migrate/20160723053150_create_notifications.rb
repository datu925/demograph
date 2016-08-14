class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :days_before

      t.timestamps null: false
    end
  end
end
