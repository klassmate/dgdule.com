class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :title
      t.string :category
      t.string :department
      t.string :provider
      t.string :extra
      t.integer :upvote_count
      t.integer :downvote_count
      t.integer :assessment_count

      t.timestamps
    end
  end
end
