class TaggingsController < ApplicationController
  include LecturesHelper

  before_filter :find_lecture
  skip_before_filter :verify_authenticity_token

  def new
    @tags = Tag.predefined_set
    @tagging = Tagging.new
  end

  def create
    tagging = Tagging.new

    tagging.user = current_user
    tagging.lecture_id = @lecture.id
    tagging.tag_id = params[:tag_id]
    tagging.coord_x = params[:coord_x]
    tagging.coord_y = params[:coord_y]

    tagging.save

    respond_to do |format|
      format.json { render json: { result: true } }
    end
  end

  private
    def find_lecture
      if params[:lecture_id]
        @lecture = Lecture.find params[:lecture_id]
      end
    end
end
