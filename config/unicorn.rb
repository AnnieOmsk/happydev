# define paths and filenames
deploy_to = "/home/happydev/www/happydev"
app_root = "#{deploy_to}/current"
pid_file = "#{deploy_to}/shared/pids/unicorn.pid"
log_file = "#{app_root}/log/unicorn.log"
err_log = "#{app_root}/log/unicorn_error.log"
old_pid = pid_file + '.oldbin'
socket_file= "#{deploy_to}/shared/unicorn.sock"

timeout 30
worker_processes 1 # increase or decrease
listen socket_file, :backlog => 1024

pid pid_file
rails_env = 'production'
stderr_path err_log
stdout_path log_file

# make forks faster
preload_app true

# make sure that Bundler finds the Gemfile
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_root}/Gemfile"
  #File.expand_path('../Gemfile', File.dirname(__FILE__))
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!

  # zero downtime deploy magic:
  # if unicorn is already running, ask it to start a new process and quit.
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|

  # re-establish activerecord connections.
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end
