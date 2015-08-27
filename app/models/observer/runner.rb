require 'open-uri'
module Observer
  module Runner
    def self.run
      get_urls.each do |url|
        page = Nokogiri::HTML(open(url))   
        puts page.class
      end
    end  

    def self.get_urls
      info = []
      User.all.each do |user|
        user.posts.each do |post|
          title = post.title.split.join("+")
          category = codename(post.category)
          location = post.location.downcase
          url = "https://#{location}.craigslist.org/search/#{category}?sort=date&query=#{title}"
          info << url
        end
      end
      return info
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
