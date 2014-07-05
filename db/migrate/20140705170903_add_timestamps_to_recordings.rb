class AddTimestampsToRecordings < ActiveRecord::Migration
  def change
    add_timestamps :recordings
  end
end
