source 'https://rubygems.org'
ruby '2.0.0'

# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'rails', '4.0.1'
gem 'rails-observers'

# gem 'sqlite3'
# gem 'mysql2'
gem 'pg'

gem 'jquery-rails'
gem 'gitlab-grit', '2.6.0'
gem 'github-markup'
gem 'github-markdown'
gem 'gollum-lib'

gem 'sorcery'
gem 'active_decorator'
gem 'settingslogic'

# WebSocket
gem 'private_pub'
gem 'thin' # websocket
gem 'puma' # web

# gem 'redis'
gem 'tire' # for ElasticSearch

gem 'protected_attributes'
gem 'haml-rails'
gem 'sass-rails'
# gem 'sprockets-rails', :github => 'rails/sprockets-rails'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'font-awesome-rails'
gem 'coffee-rails'
gem 'turbolinks'
gem 'foreman'

group :assets do

  gem 'uglifier'
  gem 'jquery-ui-rails'
  # gem 'libv8'
  # gem 'therubyracer'
  gem 'bootstrap-sass-rails'
  # gem 'bootstrap-editable-rails'
end


group :production do
  gem 'aws-ses', require: 'aws/ses'
end

group :development do
  # gem 'debugger'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-debugger'
  # gem 'pry-nav'
  # gem 'pry-coolline'
  gem 'pry-stack_explorer'
  gem 'pry-remote'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'i18n_generators'
  gem 'rails-footnotes'
  gem 'bullet'
  gem 'meta_request' # development log viewer for Chrome. via --- https://chrome.google.com/webstore/detail/railspanel/gjpfobpafnhjhbajcjgccbbdofdckggg
  gem 'rails-erd'
  gem 'letter_opener'
  gem 'guard'
  gem 'guard-livereload'  # Chrome Extention: https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'guard-rspec'
  gem "spring-commands-rspec"
end

group :test do
  gem 'coveralls', :require => false
  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
  gem 'database_cleaner'
end
