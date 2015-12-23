module VideoHelper

  def video_object(code)
    Yt::Video.new :id => strip_tags(code).squish
  end

  def video_small_thumbnail(code)
    video_object(code).thumbnail_url
  end

  def video_medium_thumbnail(code)
    video_small_thumbnail(code).gsub('default', 'mqdefault')
  end

  def video_large_thumbnail(code)
    video_small_thumbnail(code).gsub('default', 'hqdefault')
  end

end
