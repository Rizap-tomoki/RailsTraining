require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
 config.before(:each, type: :system) do
  driven_by :remote_chrome
  Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
  Capybara.server_port = 4444
  Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
 end
 
 config.before(:each, :js, type: :system) do
  driven_by :remote_chrome
  Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
  Capybara.server_port = 4444
  Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
 end
end
 
# Chrome
Capybara.register_driver :remote_chrome do |app|
 url = 'http://chrome:4444/wd/hub'


options = Selenium::WebDriver::Chrome::Options.new
#アプリケーション自体に拡張機能を追加する必要がない        
  options.add_argument('disable-extensions') 
#Userが操作する必要がないためセキュリティー環境を作成する必要がない
  options.add_argument('disable-sandbox')
#初期のWindowサイズを指定し、一般的な画面サイズでテストする         
  options.add_argument('window-size=1280,960')  
#Userが操作する必要はないためheadlessを有効にする        
  options.add_argument('headless')

 Capybara::Selenium::Driver.new(
 app,
 browser: :remote,
 url: url, 
 options: options
 )
end