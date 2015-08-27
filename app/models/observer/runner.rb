require 'open-uri'
module Observer
  module Runner
    def self.run
      titles = []
    end  

    def self.get_url
      info = []
      User.all.each do |user|
        user.posts.each do |post|
          title = post.title.split.join("+")
          category = codename(post.category)
          location = post.location.downcase
          url = "#{location}.craigslist.org/search/#{category}?sort=date&query=#{title}"
          info << url
        end
      end
      puts info
    end

    def self.codename(name)
      codenames = {"For Sale" => "sss", "Housing" => "hhh"}
      if codenames.include?(name)
        return codenames[name]
      end
    end
    def self.test
      puts "TEST"
    end
  end
end
