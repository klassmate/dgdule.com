class Lecture < ActiveRecord::Base
  include Tire::Model::Search

  has_many :assessments
  has_many :taggings
  after_initialize :initialize_with_defaults

  validates :provider, uniqueness: { scope: :title }

  index_prefix 'dongguk'
  mapping do
    indexes :id, :type => 'string', :index => :not_analyzed
    indexes :title
    indexes :provider
  end

  def initialize_with_defaults
    self.upvote_count ||= 0
    self.downvote_count ||= 0
    self.assessment_count ||= 0
    self.hit_count ||= 0

    self.overall_score ||= 0
    self.presentation_score ||= 0
    self.workload_score ||= 0
    self.grading_score ||= 0
    self.difficulty_score ||= 0
    self.insight_score ||= 0
  end

  def update_assessment_count
    sql = <<-SQL
      SELECT
        COUNT(*) as count,
        AVG(overall_score) as overall_score,
        AVG(presentation_score) as presentation_score,
        AVG(workload_score) as workload_score,
        AVG(grading_score) as grading_score,
        AVG(difficulty_score) as difficulty_score,
        AVG(insight_score) as insight_score
      FROM assessments
      WHERE lecture_id = #{id}
    SQL

    aggregated = ActiveRecord::Base.connection.execute(sql).first

    if aggregated.is_a? Hash
      self.assessment_count = aggregated['count']
      self.overall_score = aggregated['overall_score']
      self.presentation_score = aggregated['presentation_score']
      self.workload_score = aggregated['workload_score']
      self.grading_score = aggregated['grading_score']
      self.difficulty_score = aggregated['difficulty_score']
      self.insight_score = aggregated['insight_score']
    else
      self.assessment_count = aggregated[0]
      self.overall_score = aggregated[1]
      self.presentation_score = aggregated[2]
      self.workload_score = aggregated[3]
      self.grading_score = aggregated[4]
      self.difficulty_score = aggregated[5]
      self.insight_score = aggregated[6]
    end

    save
  end

  def update_hit_count
    self.hit_count += 1
    save
  end
end
