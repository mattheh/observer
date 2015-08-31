require 'open-uri'
module Observer
  module Runner
    def self.run
      User.all.each do |user|
        to_mail = []
        user.posts.each do |post|
          next if !post.active
          page = Nokogiri::HTML(open(get_url(post)))   
          page.css("p").each do |link|
            begin
              break if !new_posting?(post, link)
              (to_mail << "#{post.location.downcase}.craigslist.org#{link.css("a").attr("href").value}") if (link.css("span.price").first.inner_text.split("$")[1].to_i < post.price)
            rescue
            else
            end
          end
        end
        UserMailer.mail_urls(user, to_mail).deliver_now if to_mail.any?
      end
    end  

    def self.get_url(post)
      title = post.title.split.join("+")
      category = codename(post.category)
      location = post.location.downcase
      url = "https://#{location}.craigslist.org/search/#{category}?sort=date&query=#{title}"
    end

    def self.codename(name)
      codenames = {"For Sale" => "sss", "Housing" => "hhh"}
      if codenames.include?(name)
        return codenames[name]
      end
    end

    def self.new_posting?(post, link)
      location = post.location.downcase
      inner_page = Nokogiri::HTML(open("https://#{location}.craigslist.org#{link.css("a").attr("href").value}"))
      post_time = Time.parse(inner_page.css("p").children.css("time").last.attr("datetime"))
      return false if (Time.now - post_time) > 300
      return true
    end
  end
end
