class MainController < ApplicationController
  helper_method :cms_address
  before_filter :prepare_locale
  before_filter :prepare_cms
  before_filter :check_country

  include ApplicationHelper
  include Manage::ManageHelper

  def index
    @implemented = Event.send(locale).implemented.first
    @postponed = Event.send(locale).postponed.last
    @now = Event.send(locale).now.first

    render "templates/#{page.template}" unless page.template == 'on_client'
  end

  private
    def prepare_locale
      I18n.locale = request.fullpath.gsub(/\?.*$/, '').split('/').map(&:presence).compact.first || 'ru'
    end

    def prepare_cms
      render :file => "#{Rails.root}/public/404", :format => :html, :layout => false and return if request_status == 404

      if request.xhr?
        render_partial_for_region(request_hashie)

        return
      end

      page_regions.each do |region|
        eval "@#{region} = page.regions.#{region}"
      end

      @current_path = request.fullpath.gsub(/\?.*$/, '')

      @page_title = page.title
      @page_meta = page.meta
      @link_to_json = remote_url
    end

    def check_country
      return unless request.fullpath.match(/^\/$/)
      return if remote_ip == '127.0.0.1' || request.user_agent.to_s.match(/\(.*https?:\/\/.*\)/)
      geo_data = GeoIP.new(Rails.root.join('GeoLiteCity.dat'))
      country = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first.to_s.upcase.presence || geo_data.city(remote_ip).try(:country_code2)
      puts country
      redirect_to '/en' if country != 'RU' && I18n.locale != :en
    end

    def remote_ip
      request.remote_ip || nil
    end

    def cms_address
      "#{Settings['cms.url']}/nodes/#{Settings['cms.site_slug']}"
    end

    def remote_url
      request_path, parts_params = request.fullpath.split('?')
      "#{cms_address}#{request_path.split('/').compact.join('/')}.json?#{parts_params}"
    end

    def page
      @page ||= request_hashie.page
    end

    def curl_request
      @curl_request ||= Curl::Easy.perform(remote_url) do |curl|
        curl.headers['Accept'] = 'application/json'
      end
    end

    def request_hashie
      @request_hashie ||= Hashie::Mash.new(request_json)
    end

    def request_status
      @request_status ||= curl_request.response_code
    end

    def request_body
      @request_body ||= curl_request.body_str
    end

    def is_json?(str)
      begin
        !!JSON.parse(str)
      rescue
        false
      end
    end

    def request_json
      @request_json ||= begin
                          raise 'Response is not a JSON' unless is_json?(request_body)
                          ActiveSupport::JSON.decode(request_body)
                        end
    end

    def page_regions
      @page_regions ||= page.regions.keys
    end
end
