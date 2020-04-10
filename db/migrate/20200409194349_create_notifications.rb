class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :recipient_id
      t.string :action
      t.boolean :read
      t.string :text

      t.timestamps
    end
  end
end
