class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.integer :user_id
      t.index :user_id
      t.integer :recording_id
      t.index :recording_id
      t.timestamps
    end
  end
end
