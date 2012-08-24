require 'bundler/capistrano'
require "rvm/capistrano"
require 'capistrano/ext/multistage'
load 'deploy/assets'

set :rvm_path,     '$HOME/.rvm'
set :rvm_bin_path, '$HOME/.rvm/bin'
set :repository,  'git@github.com:inem/happydev.git'

set :scm,         :git
# set :deploy_via,  :export
set :deploy_via, :remote_cache
set :copy_exclude, ['.git']

set :rvm_ruby_string, 'ruby-1.9.3-p194'

set :use_sudo,    false
set :normalize_asset_timestamps, false    # For Rails 3.1

default_run_options[:pty]   = true
ssh_options[:forward_agent] = true

namespace :deploy do
  task :restart do
    run "cd #{current_path}; touch tmp/restart.txt"
  end

  task :sql_symlink do
    # run "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end

  namespace :assets do
    task :precompile do
      run "ln -nfs #{shared_path}/assets/ #{current_path}/public/"
      run <<-EOF
        FROM=`cat #{previous_release}/REVISION` &&
        echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>> FROM:'
        echo $FROM &&
        TO=`cat #{release_path}/REVISION` &&
        echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>> TO:'
        echo $TO &&
        cd #{shared_path}/cached-copy &&
        STATUS=`git log ${FROM}..${TO} -- app/assets vendor/assets | wc -l | sed 's/^ *//g'` &&
        if [ $STATUS -eq 0 ]; then echo "No assets changed. Skipping compilation..."; else cd #{current_path} && rake assets:precompile RAILS_ENV=#{rails_env}; fi
      EOF
    end
  end
end

# after "deploy:setup" do
#   run "mkdir -p #{deploy_to}/shared/pids && mkdir -p #{deploy_to}/shared/config && mkdir -p #{deploy_to}/shared/var"
# end

namespace :unicorn do
  task :start do
    run "cd #{deploy_to}/current && unicorn_rails -c #{deploy_to}/current/config/unicorn.rb -E #{rails_env} -D"
  end

  task :stop do
    run "kill -s QUIT `cat #{deploy_to}/shared/pids/unicorn.pid`"
  end

  task :restart do
    run "kill -s USR2 `cat #{deploy_to}/shared/pids/unicorn.pid`"           # needs if preload_app = true
    # run "kill -HUP `cat #{deploy_to}/shared/pids/unicorn.pid`"            # needs if preload_app = false
  end
end

before 'deploy:assets:precompile', 'deploy:sql_symlink'
after 'deploy:update', 'unicorn:restart', 'deploy:cleanup'
# deploy:migrate

# require './config/boot'
# require 'airbrake/capistrano'
