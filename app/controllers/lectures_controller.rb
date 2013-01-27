class LecturesController < ApplicationController
  def index
    @lectures = Lecture.paginate(page: params[:page] || 1)
  end

  def search
    @query = params[:query]
    @query.gsub!(/[+\-|!(){}\[\]\^"~*?:\\]/, "\\\\\\0") if @query

    if @query && @query.length > 0
      @lectures = Lecture.search("*#{@query}*", :page => params[:page] || 1, :per_page => 10, :load => true)
    else
      @lectures = Lecture.paginate :page => params[:page] || 1
    end

    render :index
  end

  def show
    @lecture = Lecture.find params[:id]
    @lecture.update_hit_count
    @assessment = Assessment.new
    @assessments = @lecture.assessments.all
  end
end
