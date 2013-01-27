class AddNicknameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :nickname
      t.integer :transaction_id
    end
  end
end
