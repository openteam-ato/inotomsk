require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Inotomsk
  class Application < Rails::Application
    config.app_generators.scaffold_controller :responders_controller

    config.time_zone = 'Krasnoyarsk'

    config.i18n.default_locale = :ru
    config.i18n.available_locales = [:ru, :en]

    config.autoload_paths += %W(
      #{config.root}/lib
    )

    config.to_prepare do
      Devise::Mailer.layout 'email'
    end

    config.active_record.raise_in_transactional_callbacks = true
  end
end
