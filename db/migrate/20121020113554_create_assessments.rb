class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.integer :lecture_id
      t.integer :user_id
      t.float :overall_score
      t.integer :presentation_score
      t.integer :workload_score
      t.integer :grading_score
      t.integer :difficulty_score
      t.integer :insight_score
      t.text :content

      t.timestamps
    end
  end
end
