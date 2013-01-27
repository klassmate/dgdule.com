class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :assessment_count
      t.string :username
      t.timestamps
    end
  end
end
