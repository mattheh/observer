namespace :posts do
  desc "Runs through active posts"
  task :run => :environment do
    Observer::Runner.run
    puts Time.now

  end
end
