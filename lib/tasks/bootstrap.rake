namespace :db do
  task :bootstrap => :environment do
    Rake::Task["db:reset"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:load"].invoke
    Rake::Task["db:create_welcome_post_and_comment"].invoke
  end
  
  desc "Load initial fixtures into the current environment's database."
  task :load => :environment do
    blog = Blog.create(:email => "email@email.com",
                       :time_zone => 'New Delhi',
                       :feeds_description => "Short",
                       :sub_title => "blog sub title")

    ROLES_NAMES.each{ |name| Role.create(:name => name) }

    user = User.create(:login => LOGIN, 
                       :email => EMAIL,
                       :password => PASSWORD,
                       :password_confirmation => PASSWORD)
    user.activate!
    user.roles << Role.find_by_name('admin')
    
    puts ''
    puts "    ################### ADMIN CREDENTIALS ######################"
    puts "    #                                                          #"
    puts "    #                Login: #{LOGIN}                              #"
    puts "    #             password: #{PASSWORD}                           #"
    puts "    #                email: #{EMAIL}                    #"    
    puts "    #            admin url: http://domain.com/admin/login      #"    
    puts "    #                                                          #"
    puts "    ############################################################"
    puts ''
    
  end
  
  task :create_welcome_post_and_comment => :environment do
    post = Post.new(:title => "Welcome", :description => " Welcome to the BlogApp. This post is a test post")
    user = User.first
    user.posts << post
    post.publish!
    comment = post.comments.create(:author => user.login, :description => "This is the test comment", :author_email => user.email)
    comment.approve!
  end
  
end 