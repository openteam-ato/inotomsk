# encoding: utf-8

module ApplicationHelper
  def canonical_url
    return "<link rel='canonical' href='/' />" if request.path == '/ru'

    ''
  end

  def render_partial_for_region(region)
    if region && (region.response_status == 200 || !region.response_status?)
      render partial: "regions/#{region.template}",
             locals: { object: region.content, response_status: region.response_status }
    else
      render partial: 'regions/error', locals: { region: region }
    end
  end

  def languages(pull = 'pull-right')
    res = ''

    I18n.available_locales.each_with_index do |lang, _index|
      res += if I18n.locale == lang
               content_tag :li, I18n.t("locale.#{lang}"), title: I18n.t("locale.#{lang}_title"), class: 'active'
             else
               content_tag :li, link_to(I18n.t("locale.#{lang}"), (@page.related_pages.try(:[], lang) || "/#{lang}").to_s, title: I18n.t("locale.#{lang}_title"))
             end
    end
    content_tag :ul, res.html_safe, class: ['languages', pull]
  end

  def entry_date
    @entry_date ||= begin
                      @page.regions.to_hash.each do |_region_name, region|
                        if (since = region.try(:[], 'content').try(:[], 'since'))
                          return since
                        end
                      end
                      nil
                    end
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
    strip_tags(truncate(strip_tags(text), length: 200, separator: ' ')).html_safe
  end

  def interval_for(event)
    since_date, since_time = l(event.since.to_datetime, format: '%d.%B.%Y %H:%M').split(' ')
    until_date, until_time = l(event.until.to_datetime, format: '%d.%B.%Y %H:%M').split(' ')

    since_date.tr!('.', ' ')
    until_date.tr!('.', ' ')

    since_arr = []
    until_arr = []

    since_arr << content_tag(:span, since_date, class: 'nobr')
    until_arr << content_tag(:span, until_date, class: 'nobr') if since_date != until_date

    if since_time != '00:00'
      since_arr << ", #{since_time}"
      if until_time != '00:00' && until_time != '23:59'
        if since_time != until_time
          until_arr << if until_arr.empty?
                         until_time
                       else
                         ", #{until_time}"
                       end
        else
          until_arr << ", #{until_time}" unless until_arr.empty?
        end
      end
    else
      if until_time != '00:00' && until_time != '23:59'
        until_arr << ", #{until_time}" unless until_arr.empty?
      end
    end

    res = since_arr.join

    unless until_arr.empty?
      res += ' &mdash; '
      res += until_arr.join
    end

    res.html_safe
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
    image_dup = image.dup
    image_dup.width = width
    image_dup.height = height
    image_dup.url = image.url.gsub(/\d+-\d+/, "#{width}-#{height}!")
    image_tag_for(image_dup)
  end

  def image_tag_for(image, options = {})
    image_tag(image.url, width: image.width, height: image.height, alt: image.description, class: options[:class])
  end

  def inoorganization_logo(image_url, width = 100)
    original_width, original_height = image_url[/\d+-\d+/].split('-')
    height = width * original_height.to_f / original_width.to_f
    image_tag image_url.gsub(/\d+-\d+/, "#{width}-#{height.to_i}"), size: "#{width}x#{height.to_i}"
  end

  def inoorganization_phones(phones)
    res = []
    phones.split(';').each do |phone|
      res << "#{content_tag(:strong, "#{phone.split(':')[0]}:")} #{phone.split(':')[1]}"
    end
    res.join('; ').html_safe
  end

  def inoorganization_emails(emails)
    res = []
    emails.each do |email|
      res << mail_to(email)
    end
    "#{content_tag :strong, 'Email:'} #{res.join(', ')}".html_safe
  end

  def inoorganization_url(url)
    site = /^http/ =~ url ? url : "http://#{url}"
    link_to site, site, rel: 'nofollow', target: '_blank'
  end

  def road_map_navigation
    clear_params = params.reject { |key, _value| %w(state action controller slug page).include?(key) }
    {
      'all' => {
        'title' => I18n.t('all_nav'),
        'path' => [@current_path, clear_params.to_param].delete_if(&:blank?).join('?'),
        'selected' => params[:state].nil? ? true : false
      },
      'implemented' => {
        'title' => I18n.t('implemented_nav'),
        'path' => [@current_path, { state: 'implemented' }.merge(clear_params).to_param].delete_if(&:blank?).join('?'),
        'selected' => params['state'] == 'implemented'
      },
      'now' => {
        'title' => I18n.t('now_nav'),
        'path' => [@current_path, { state: 'now' }.merge(clear_params).to_param].delete_if(&:blank?).join('?'),
        'selected' => params[:state] == 'now'
      },
      'postponed' => {
        'title' => I18n.t('postponed_nav'),
        'path' => [@current_path, { state: 'postponed' }.merge(clear_params).to_param].delete_if(&:blank?).join('?'),
        'selected' => params[:state] == 'postponed'
      }
    }
  end

  def map_layer_nav
    {
      'peredovoe-proizvodstvo' => 'Передовое производство',
      'nauka-i-obrazovanie' => 'Наука и образование',
      'umnyy-i-udobnyy-gorod' => 'Умный и удобный город',
      'innovatsii-i-noviy-biznes' => 'Технологические инновации и новый бизнес',
      'delovaya-sreda' => 'Деловая среда'
    }
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def active_layout
    (controller.send :_layout).inspect.split('/').last.gsub(/.html.erb/, '')
  end
end
