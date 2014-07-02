class RemovePinAddPhoneNumberToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :pin
    add_column :users, :phone_number, :string
  end
end
