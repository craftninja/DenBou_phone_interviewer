class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.string :recording
      t.integer :user_id
      t.index :user_id
      t.integer :question_id
      t.index :question_id
    end
  end
end
