require "bundler/capistrano"
#require "delayed/recipes"
require 'capistrano/ext/multistage'

set :stages, %w(staging production)
set :default_stage, "staging"
set :bundle_flags, '--deployment'

server "helperchat.com", :web, :app, :db, primary: true
set :port, 22

set :application, "chat"
set :user, "deploy"
set :deploy_via, :remote_cache
set :use_sudo, false
#set :default_shell, :bash

set :scm, "git"
set :repository, "git@github.com:bublik/#{application}.git"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after 'deploy:update_code', 'deploy:migrate'
after "deploy", "deploy:cleanup"#, "deploy:assets:clean", "deploy:assets:precompile"

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
#after "deploy:restart", "delayed_job:restart"

namespace :deploy do
  task :start do; end
  task :stop do; end
  task :restart, roles: :app, except: {no_release: true} do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end

  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
    run "mkdir -p #{release_path}/public/assets"
    run "ln -s #{shared_path}/uploads #{release_path}/public"
    run "rm -rf #{shared_path}/tmp/*" # clean temporary google contact images
    run "ln -s #{shared_path}/tmp #{release_path}/public/tmp"
  end

  after "deploy:finalize_update", "deploy:symlink_config"
end
