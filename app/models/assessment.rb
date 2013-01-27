class Assessment < ActiveRecord::Base
  attr_accessible :content, :presentation_score, :workload_score, :grading_score, :difficulty_score, :insight_score

  belongs_to :lecture
  belongs_to :user

  before_save :calculate_overall_score
  after_save :update_assessment_count_of_lecture
  after_save :update_assessment_count_of_user

  after_initialize :initialize_with_defaults

  validates :user_id, presence: true, uniqueness: { scope: :lecture_id }
  validates :presentation_score, presence: true, inclusion: { in: 1..10 }
  validates :workload_score, presence: true, inclusion: { in: 1..10 }
  validates :grading_score, presence: true, inclusion: { in: 1..10 }
  validates :difficulty_score, presence: true, inclusion: { in: 1..10 }
  validates :insight_score, presence: true, inclusion: { in: 1..10 }

  default_scope { order 'id DESC' }

  def best_or_worst
    overall_score > 5 ? 'best' : 'worst'
  end

  def self.voted_for(criteria)
    if criteria == :best
      self.best
    else
      self.worst
    end
  end

  def self.best
    where('overall_score >= 8.0')
  end

  def self.worst
    where('overall_score <= 3.0')
  end

  private
    def initialize_with_defaults
      self.presentation_score ||= 1
      self.workload_score ||= 1
      self.grading_score ||= 1
      self.difficulty_score ||= 1
      self.insight_score ||= 1
    end

    def calculate_overall_score
      self.overall_score = (presentation_score + workload_score + grading_score + difficulty_score + insight_score) / 5.0
    end

    def update_assessment_count_of_lecture
      lecture.update_assessment_count
    end

    def update_assessment_count_of_user
      user.update_assessment_count
    end
end
