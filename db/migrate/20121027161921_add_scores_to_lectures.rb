class AddScoresToLectures < ActiveRecord::Migration
  def change
    change_table :lectures do |t|
      t.float :overall_score
      t.float :presentation_score
      t.float :workload_score
      t.float :grading_score
      t.float :difficulty_score
      t.float :insight_score
    end
  end
end
