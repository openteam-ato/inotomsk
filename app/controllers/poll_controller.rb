class PollController < ApplicationController
  def show
    if params[:code]
      uri = URI("http://webanketa.com/forms/#{params[:code]}/ru/statistic/")
      result = Net::HTTP.get_response(uri)
      if result.is_a?(Net::HTTPSuccess) && !result.body.match('Unfortunately, this form does not exist')
        render(text: result.body.gsub('href="', 'href="http://webanketa.com').gsub('src="', 'src="http://webanketa.com'), layout: false) && return
      end
    end
    redirect_to root_path
  end
end
