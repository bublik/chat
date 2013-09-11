set :directory, "staging"
set :branch, "develop"
set :deploy_to, "/var/www/#{directory}"
set :rails_env, 'staging'
#set :delayed_job_args, '-i 2'