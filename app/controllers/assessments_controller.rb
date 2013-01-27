class AssessmentsController < ApplicationController
  include AssessmentsHelper

  before_filter :find_lecture

  def new
    previous_assessment = current_user.assessment_for(@lecture)
    if previous_assessment
      @assessment = previous_assessment
    else
      @assessment = Assessment.new
    end
  end

  def index
    @assessments = Assessment.paginate(page: params[:page] || 1)
    @lectures = Lecture.where('assessment_count > 2').order('overall_score DESC').paginate(page: 1, per_page: 20)
  end

  def create
    @assessment = Assessment.new params[:assessment]
    @assessment.lecture = @lecture
    @assessment.user = current_user

    if @assessment.save
      redirect_to @lecture
    else
      flash[:alert] = @assessment.errors.full_messages.first
      render 'lectures/show'
    end
  end

  def update
    @assessment = Assessment.find params[:id]

    if @assessment.update_attributes params[:assessment]
      redirect_to @lecture
    else
      render :new
    end
  end

  private
    def find_lecture
      if params[:lecture_id]
        @lecture = Lecture.find params[:lecture_id]
      end
    end
end
