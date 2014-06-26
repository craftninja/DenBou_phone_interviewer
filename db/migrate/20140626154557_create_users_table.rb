class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :access_token
      t.string :email
      t.string :first_name
      t.string :last_name
    end
  end
end
