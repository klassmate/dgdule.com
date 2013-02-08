class AddDepartmentToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :department
    end
  end
end
