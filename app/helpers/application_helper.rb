# encoding: utf-8

module ApplicationHelper

  def render_partial_for_region(region)
    if region && (region.response_status == 200 || !region.response_status?)
      render :partial => "regions/#{region.template}",
             :locals => { :object => region.content, :response_status => region.response_status }
    else
      render :partial => 'regions/error', :locals => { :region => region }
    end
  end

  def languages
    res = ''
    I18n.available_locales.each_with_index do |lang, index|
      if I18n.locale == lang
        res += content_tag :li, I18n.t("locale.#{lang}")
      else
        res += content_tag :li, link_to(I18n.t("locale.#{lang}"), "/#{lang}/")
      end
      res += content_tag :li, '|', :class => 'separator' if index < I18n.available_locales.size - 1
    end
    content_tag :ul, res.html_safe
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

  def event_interval(since_str, until_str)
    since_day, since_month, since_year, since_time = l(since_str.to_datetime, :format => :long).gsub(',', '').split(' ').to_a
    until_day, until_month, until_year, until_time = l(until_str.to_datetime, :format => :long).gsub(',', '').split(' ').to_a
    since_arr = []
    until_arr = []
    if since_year == until_year
      until_arr << content_tag(:span, until_year, :class => 'year')
    else
      since_arr << since_year
      until_arr << until_year
    end
    if since_month == until_month && since_day == until_day
      until_arr << "#{until_month},"
    else
      since_arr << since_month
      until_arr << "#{until_month},"
    end
    if since_month == until_month && since_day == until_day
      until_arr << until_day
    else
      since_arr << since_day
      until_arr << until_day
    end
    if since_time == until_time && since_month == until_month && since_day == until_day
      if since_time != '00:00'
        until_arr << until_time
      end
    else
      since_arr << since_time if since_time != '00:00'
      if until_time != '00:00'
        until_arr << until_time
        until_arr << "&mdash;<br />"
      else
        until_arr << "&mdash;<br />"
      end
    end
    until_arr.delete('23:59')
    (since_arr.reverse + until_arr.reverse).join(' ')
  end

  def intervals
    res = []
    year = Date.today.year
    (1..12).each do |month|
      res << "01.#{month}.#{year}".to_date.beginning_of_month
      res << "01.#{month}.#{year}".to_date.end_of_month
    end
    res
  end

  def album_thumbnail(image, width = 176, height = 116)
    image.width = width
    image.height = height
    image.url.gsub!(/\d+-\d+/, "#{width}-#{height}!")
    image_tag_for(image)
  end

end
