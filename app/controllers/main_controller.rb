class MainController < ApplicationController
  helper_method :cms_address

  def index
    page_regions.each do |region|
      eval "@#{region} = page.regions.#{region}"
    end

    @page_title = page.title

    render "templates/#{page.template}"
  end

  private
    def cms_address
      "#{Settings['cms.url']}/nodes/#{Settings['cms.site_slug']}"
    end

    def remote_url
      request_path, parts_params = request.fullpath.split('?')

      # TODO: выяснить нужно ли энкодить
      #parts_params = URI.encode(parts_params || '')

      "#{cms_address}#{request_path.split('/').compact.join('/')}.json?#{parts_params}"
    end

    def page
      @page ||= Hashie::Mash.new(json).page
    end

    def json
      body = Curl::Easy.perform(remote_url) do |curl|
        curl.headers['Accept'] = 'application/json'
      end.body_str

      ActiveSupport::JSON.decode(body)
    end

    def page_regions
      page.regions.keys
    end
end
