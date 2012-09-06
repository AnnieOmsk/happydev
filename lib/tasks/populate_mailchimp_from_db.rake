# encoding: utf-8

# load production config settings
MAILCHIMP_PRODUCTION = YAML.load_file("#{Rails.root.to_s}/config/config.yml")['production']['mailchimp']
API_KEY = MAILCHIMP_PRODUCTION['api_key']
LIST_ID = MAILCHIMP_PRODUCTION['list_id']

namespace :mailchimp do
  desc 'iterates over all users in database and add their to mailchimp with names'
  task :update => :environment do
    
    User.all.each do |user|
      names = {'FNAME' => user.first_name, 'LNAME' => user.last_name }.delete_if { |_, value| value.nil? }
      @hominid = Hominid::API.new(API_KEY)
      @hominid.list_subscribe(LIST_ID, user.email, names, 'html', false, true, true, false)
    end
  end
end
