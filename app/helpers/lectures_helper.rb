# encoding=utf-8

module LecturesHelper
  def lecture_container(lecture, rank = nil)
    elements = []

    elements << (content_tag :span, '{', class: 'curly-braces')
    elements << (content_tag :span, lecture.provider, class: 'provider')
    elements << (content_tag :span, '/', class: 'separator')
    elements << (content_tag :span, lecture.title, class: 'title')
    elements << (content_tag :span, '}', class: 'curly-braces')


    if rank
      rank_element = content_tag('div', content_tag('span', rank, class: 'number').html_safe + content_tag('span', '.', class: 'tail').html_safe, class: 'rank').html_safe
      main_div = content_tag('div', elements.join('').html_safe, class: 'lecture').html_safe

      content_tag('div', rank_element + main_div, class: 'ranked-lecture').html_safe
    else
      content_tag('div', elements.join('').html_safe, class: 'lecture').html_safe
    end
  end

  def score_indicators(score)
    if score > 0
      full_star_tag = content_tag('div', '', class: 'score-stars full').html_safe
      half_star_tag = content_tag('div', '', class: 'score-stars half').html_safe

      rounded = score.round

      full_stars_count = rounded / 2
      half_star_count = rounded % 2

      elements = []

      full_stars_count.times do
        elements << full_star_tag.dup
      end

      half_star_count.times do
        elements << half_star_tag.dup
      end

      elements.join("").html_safe
    else
      content_tag(:p, '지금 투표해 보세요!', class: 'empty').html_safe
    end
  end

  def tagging_to_image_tag(tagging)
    tag = Tag.find(tagging.tag_id)
    style = "left: #{tagging.coord_x}px; top: #{tagging.coord_y}px"

    image_tag(asset_path(tag.image_file_name), class: 'tagged', style: style).html_safe
  end
end
