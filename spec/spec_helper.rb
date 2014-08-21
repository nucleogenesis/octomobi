require 'factory_girl'
require 'database_cleaner'
require 'devise'
require 'capybara'

RSpec.configure do |config|
	config.include FactoryGirl::Syntax::Methods
	config.include Devise::TestHelpers, type: :controller
	config.include Warden::Test::Helpers, type: :controller
end
