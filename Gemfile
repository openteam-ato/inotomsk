source :rubygems

gem 'compass',              '~> 0.12.alpha.0'
gem 'configliere'
gem 'el_vfs_client'
gem 'jquery-rails'
gem 'rails'

group :assets do
  gem 'sass-rails'
  gem 'therubyracer'                                unless RUBY_PLATFORM =~ /freebsd/
  gem 'uglifier'
end

group :production do
  gem 'hoptoad_notifier'
  gem 'pg',                 :require => false
  gem 'unicorn',            :require => false       unless ENV['SHARED_DATABASE_URL']
end
