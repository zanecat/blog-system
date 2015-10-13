class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :unsubscriber_id
      t.integer :unsubscribed_id
      t.boolean :processed

      t.timestamps null: false
    end
  end
end
