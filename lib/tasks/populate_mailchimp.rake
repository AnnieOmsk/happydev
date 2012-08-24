# encoding: utf-8

# load production config settings
MAILCHIMP_PRODUCTION = YAML.load_file("#{Rails.root.to_s}/config/config.yml")['production']['mailchimp']
API_KEY = MAILCHIMP_PRODUCTION['api_key']
LIST_ID = MAILCHIMP_PRODUCTION['list_id_7bits_friends']

# example of friends array
FRIENDS_EXAMPLE = [
  %w( Тарасенко Анна annie.tarasenko@7bits.it ),
  %w( Немытченко Иван ivan.nemytchenko@7bits.it )
]

FRIENDS = [
]


namespace :mailchimp do
  desc 'add emails'
  task :add => :environment do
    
    FRIENDS.each do |friend|
      @hominid = Hominid::API.new(API_KEY)
      @hominid.list_subscribe(LIST_ID, friend[2], {'FNAME' => friend[1], 'LNAME' => friend[0]}, 'html', false, true, true, false)
    end
  end
end

