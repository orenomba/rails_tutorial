#rvm
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.3@rails_tutorial'
before 'deploy:setup', 'rvm:install_rvm'   # install RVM
before 'deploy:setup', 'rvm:install_ruby'  # install Ruby and create gemset, or:
before 'deploy:setup', 'rvm:create_gemset' # only create gemset


require 'capistrano_colors'
set :application, "rails_tutorial"
set :repository,  "git@github.com:orenomba/rails_tutorial.git"
set :scm, :git

set :user, "ac"
set :use_sudo, false

role :web, "bian.local"                          # Your HTTP server, Apache/etc
role :app, "bian.local"                          # This may be the same as your `Web` server
role :db,  "bian.local", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :deploy_to, "/home/ac/fjord/deploy"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

#unicorn
require 'capistrano-unicorn'
set :unicorn_bin, "unicorn_rails"
after "deploy", "unicorn:reload"

