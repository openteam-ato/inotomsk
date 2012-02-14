module ApplicationHelper

  def news_image(url, alt = '')
    width, height = url.match(%r{files/\d+/(\d+)-(\d+)})[1..2]
    image_tag(url, :alt => alt, :width => width, :height => height)
  end

end
