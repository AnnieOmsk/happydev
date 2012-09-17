# encoding: utf-8

namespace :mailchimp do
  desc 'add emails'
  task :add => :environment do
    # load production config settings
    MAILCHIMP_PRODUCTION = YAML.load_file("#{Rails.root.to_s}/config/config.yml")['production']['mailchimp']
    API_KEY = MAILCHIMP_PRODUCTION['api_key']

    # choose a list (BE CAREFUL HERE!)
    # LIST_ID = MAILCHIMP_PRODUCTION['list_id_7bits_friends']
    # LIST_ID = MAILCHIMP_PRODUCTION['list_id_freelancers']
    LIST_ID = MAILCHIMP_PRODUCTION['list_id_companies']

    # example of list with FNAME LNAME and email
    FRIENDS_EXAMPLE = [
      %w( Тарасенко Анна annie.tarasenko@7bits.it ),
      %w( Немытченко Иван ivan.nemytchenko@7bits.it )
    ]

    # example of list with only emails
    FRIENDS_EXAMPLE = %w(
      dima.nikitenko@gmail.com
      ktmzzz@inbox.ru
    )

    # real data for subscribe:
    FRIENDS = %w(
    )
    
    FRIENDS.each do |friend|
      @hominid = Hominid::API.new(API_KEY)

      # iterate over array with first_name, last name and email:
      # @hominid.list_subscribe(LIST_ID, friend[2], {'FNAME' => friend[1], 'LNAME' => friend[0]}, 'html', false, true, true, false)
      
      # iterate over array with only emails:
      @hominid.list_subscribe(LIST_ID, friend, {}, 'html', false, true, true, false)
    end
    
    puts "Добавлено #{FRIENDS.count} емэйлов в #{LIST_ID}"
  end
end

