set :rails_env,   "production"

set :host,        'happydev.ru'
set :user,        'happydev'
set :application, "happydev"
set :unicorn_env, "production"

role :app,        host  
role :web,        host
role :db,         host, :primary => true

set :branch,    'master'
set :deploy_to, '/home/happydev/www/happydev'
