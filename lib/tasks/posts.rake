namespace :posts do
  desc "Runs through active posts"
  task run: [] do
    Observer::Runner.run
    puts Time.now

  end
end
