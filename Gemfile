source :rubygems

gem 'configliere'
gem 'curb'
gem 'el_vfs_client'
gem 'formtastic',           '~> 2.1.0.beta'
gem 'hashie'
gem 'jquery-rails'
gem 'kaminari'
gem 'rails'
gem 'russian'

group :assets do
  gem 'compass-rails'
  gem 'sass-rails'
  gem 'therubyracer'                                unless RUBY_PLATFORM =~ /freebsd/
  gem 'uglifier'
end

group :production do
  gem 'hoptoad_notifier'
  gem 'unicorn',            :require => false       unless ENV['SHARED_DATABASE_URL']
end
