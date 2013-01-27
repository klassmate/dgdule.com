class AddHitCountToLectures < ActiveRecord::Migration
  def change
    change_table :lectures do |t|
      t.integer :hit_count
    end
  end
end
