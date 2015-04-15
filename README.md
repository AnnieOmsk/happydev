happydev
========

### Installation

    vagrant up

### Apply database dump

    vagrant ssh
    mysql -uUSER -pPASSWORD happydev_2012 < happydev_2012.sql

### Start app (dev mode)

    vagrant ssh
    unicorn_rails -c config/unicorn.rb
    sudo service nginx restart

### Start app (production mode)

    vagrant ssh
    cd /app
    RAILS_ENV=production rake assets:precompile
    RAILS_ENV=production unicorn_rails -c config/unicorn.rb
    sudo service nginx restart
