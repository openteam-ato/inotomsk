source :rubygems

gem 'configliere'
gem 'curb'
gem 'esp-commons'
gem 'hashie'
gem 'jquery-rails'
gem 'kaminari'
gem 'openteam-commons'
gem 'rails'
gem 'russian'
gem 'stop_ie'

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
