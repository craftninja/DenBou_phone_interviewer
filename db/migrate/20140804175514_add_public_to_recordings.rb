class AddPublicToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :public, :boolean, default: true
  end
end
