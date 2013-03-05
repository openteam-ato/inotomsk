require "bundler/capistrano"
require "rvm/capistrano"

load "config/deploy/settings"

namespace :deploy do
  desc "Copy config files"
  task :config_app, :roles => :app do
    run "ln -s #{deploy_to}/shared/config/settings.yml #{release_path}/config/settings.yml"
  end

  desc "Copy unicorn.rb file"
  task :copy_unicorn_config do
    run "mv #{deploy_to}/current/config/unicorn.rb #{deploy_to}/current/config/unicorn.rb.example"
    run "ln -s #{deploy_to}/shared/config/unicorn.rb #{deploy_to}/current/config/unicorn.rb"
  end

  desc "Airbrake notify"
  task :airbrake do
    run "cd #{deploy_to}/current && RAILS_ENV=production TO=production bin/rake airbrake:deploy"
  end
end

namespace :unicorn do
  desc "Start Unicorn"
  task :start do
    run "/usr/local/etc/rc.d/unicorn start"
  end

  desc "Stop Unicorn"
  task :stop do
    run "/usr/local/etc/rc.d/unicorn stop"
  end

  desc "Reload Unicorn"
  task :reload do
    run "/usr/local/etc/rc.d/unicorn reload"
  end

  desc "Restart Unicorn"
  task :restart do
    run "/usr/local/etc/rc.d/unicorn restart"
  end
end

# deploy
after "deploy:finalize_update", "deploy:config_app"
after "deploy", "deploy:copy_unicorn_config"
after "deploy", "unicorn:reload"
after "deploy:restart", "deploy:cleanup"
after "deploy", "deploy:airbrake"

# deploy:rollback
after "deploy:rollback", "unicorn:restart"
