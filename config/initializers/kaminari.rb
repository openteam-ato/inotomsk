module Kaminari
  module Helpers
    class Tag
      def page_url_for(page)
        #p "=========================================================================="
        #p @params
        #p @param_name
        #p @params.delete('parts_params')

        @params.delete('parts_params')
        URI.unescape(@template.url_for @params.merge(@param_name => (page <= 1 ? nil : page)))
      end
    end
  end
end

