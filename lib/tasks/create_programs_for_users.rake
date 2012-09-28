namespace :pdf do
  desc 'create program based on liked speeches for every user'
  task :create_programs => :environment do
    User.all.each do |user|
      p = PdfBuilder.new
      p.create_program_for_user(user)
    end
  end
  
  task :create_programs_for_users_with_likes => :environment do
    User.all.each do |user|
      if user.likes.where(:status => 1).count > 0
        puts "Processing user with likes: #{user.email}"
        p = PdfBuilder.new
        p.create_program_for_user(user)
      end
    end
  end
end
