Settings.read(Rails.root.join('config', 'settings.yml'))

Settings.defaults Settings.extract!(Rails.env)[Rails.env] || {}
Settings.extract!(:test, :development, :production)

Settings.define 'hoptoad.api_key',            :env_var => 'HOPTOAD_API_KEY'
Settings.define 'hoptoad.host',               :env_var => 'HOPTOAD_HOST'

Settings.define 'cms.url',                    :env_var => 'CMS_URL',          :required => true

Settings.define 'cms.protocol',               :env_var => 'CMS_PROTOCOL',     :default => :http
Settings.define 'cms.host',                   :env_var => 'CMS_HOST',         :required => true
Settings.define 'cms.port',                   :env_var => 'CMS_PORT',         :required => true

Settings.define 'cms.site_slug',              :env_var => 'CMS_SITE_SLUG',    :required => true

Settings.resolve!
