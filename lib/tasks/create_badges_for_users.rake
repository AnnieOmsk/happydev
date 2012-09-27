namespace :pdf do
  desc 'create program based on liked speeches for every user'
  task :create_badges => :environment do
    User.all.each do |user|
      p = PdfBuilder.new
      p.create_badge_for_user(user)
    end
  end
end
