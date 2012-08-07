source 'https://rubygems.org'

gem 'rails', '3.2.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'thin'
gem 'sqlite3'
gem "sorcery"
gem 'jquery-rails'
gem "twitter-bootstrap-rails"
gem 'squeel'    
#https://github.com/mjbellantoni/formtastic-bootstrap/issues/32
# I've been using https://github.com/niedfelj/formtastic-bootstrap 
# for all my projects. More specifically, 
# https://github.com/niedfelj/formtastic-bootstrap/tree/bootstrap2-rails3-2-formtastic-2-2
gem 'formtastic-bootstrap', :git => "https://github.com/niedfelj/formtastic-bootstrap.git", :branch => 'bootstrap2-rails3-2-formtastic-2-2'
gem "i18n_generators"

#http://stackoverflow.com/questions/3524127/exception-notification-gem-and-rails-3
#https://github.com/smartinez87/exception_notification
gem 'exception_notification', :require => 'exception_notifier'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem "rspec-rails"
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git'
  gem "factory_girl_rails"
end

group :development do
  gem "quiet_assets"    
  gem "annotate", :git => "https://github.com/ctran/annotate_models.git"
  gem 'growl'
end
