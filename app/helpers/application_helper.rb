module ApplicationHelper

  def render_partial_for_region(region)
    if region && (region.response_status == 200 || !region.response_status?)
      render :partial => "regions/#{region.template}",
             :locals => { :object => region.content, :response_status => region.response_status }
    else
      render :partial => 'regions/error', :locals => { :region => region }
    end
  end

  def truncate_words(text, length = 20, end_string = '...')
    return if text.blank?
    words = text.gsub('&nbsp;', ' ').split
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end

  def belief_color
    case rand(3)
    when 0
      'blue'
    when 1
      'green'
    when 2
      'orange'
    end
  end

  def main_news_annotation(text)
    strip_tags(truncate(strip_tags(text), :length => 200, :separator => ' '))
  end

end
