set :rails_env,   "staging"
ssh_options[:port] = 21722

set :host,        'office.7bits.it'
set :user,        'happydev'
set :application, "happydev"

role :app,        host  
role :web,        host
role :db,         host, :primary => true

set :branch,    'invoice_for_students'
set :deploy_to, '$HOME/www/happydev'
