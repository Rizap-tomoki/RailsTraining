namespace :sitemap do
    desc "sitemap.xml作成"
    task generate: :environment do
      require 'builder'
      include Rails.application.routes.url_helpers
      default_url_options[:host] = 'localhost:3000'
  
      sitemap_file = Rails.root.join('public', 'sitemap.xml')
  
      File.open(sitemap_file, 'w') do |file|
        xml = Builder::XmlMarkup.new(target: file, indent: 2)
        xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
  
        xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do
          add_url(xml, root_url, 'daily', 1.0)
  
          User.find_each do |item|
            add_url(xml, user_url(item), 'weekly', 0.8)
          end
        end
      end
  
    end
  
    def add_url(xml, loc, changefreq, priority)
      xml.url do
        xml.loc        loc
        xml.lastmod    Time.now.strftime("%Y-%m-%d")
        xml.changefreq changefreq
        xml.priority   priority
      end
    end
  end