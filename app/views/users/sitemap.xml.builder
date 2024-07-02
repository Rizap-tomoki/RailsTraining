xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do
   @users.each do |user|
       xml.url do
         xml.loc user_url(user)
         xml.lastmod user.updated_at.strftime("%Y-%m-%d")
         xml.changefreq 'daily'
         xml.priority 0.5
       end
    end
end