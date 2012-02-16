module ApplicationHelper
  def news_image(url, alt = '')
    width, height = url.match(%r{files/\d+/(\d+)-(\d+)})[1..2]
    image_tag(url, :alt => alt, :width => width, :height => height)
  end

  def render_partial_for_region(region)
    if region && (region.response_status == 200 || !region.response_status?)
      render :partial => "regions/#{region.template}",
             :locals => { :object => region.content, :response_status => region.response_status }
    else
      render :partial => 'regions/error', :locals => { :region => region }
    end
  end
end
