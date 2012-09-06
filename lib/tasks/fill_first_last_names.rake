namespace :db do
  namespace :users do

    desc 'fill first and last name for users'
    task :fill_names => :environment do
      User.all.each do |user|
        
        # first users in db don't have names, so skip them
        if user.name?
          user.split_name!
          puts user.save ? "Name updated for: #{user.name}" : ">> Error while updating user #{user.name}"
        end
      end
    end

  end
end

