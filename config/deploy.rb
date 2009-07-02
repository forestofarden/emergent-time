default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, "emergent-time"
set :repository,  "git@github.com:repertoire/Emergent-Time.git"
set :scm, "git"
set :scm_command, "/opt/local/bin/git"
set :branch, "master"

role :app, "menzinga.mit.edu"
role :web, "menzinga.mit.edu"
role :db,  "menzinga.mit.edu", :primary => true

set :deploy_to,    "/Library/WebServer/Deployment/#{application}"
set :deploy_via,   :export

set :merb_cmd, "/usr/bin/merb_persist"
set :merb_ports, 4040..4040

set :user, "repertoire"
set :group, "developer"

namespace :deploy do
  
  after "deploy:update", "deploy:redeploy_gems"
  task :redeploy_gems, :roles => :app do
    run "cd #{latest_release}; bin/thor merb:gem:redeploy"
  end

  desc "debug"
  task :debug do
    run "env"
  end

  desc "run datamapper migrations"  
  task :migrate, :roles => :db, :only => { :primary => true } do
   merb_env = fetch(:merb_env, "production")
   migrate_env = fetch(:migrate_env, "") 
   run "cd #{latest_release}; bin/rake MERB_ENV=#{merb_env} #{migrate_env} db:migrate"
  end

  desc "Start Merb processes and add them to launchd."
  task :start, :roles => :app do
    merb_ports.each do |port|
      sudo "#{merb_cmd} start -p #{port} -e production \
            -u #{user} -G #{group} -m #{current_path}"
    end
  end

  desc "Stop Mongrels processes and remove them from launchd."
  task :stop, :roles => :app do
    merb_ports.each do |port|
      sudo "#{merb_cmd} stop -p #{port}"
    end
  end

  desc "Restart Mongrel processes"
  task :restart, :roles => :app do
    stop
    start
  end

end
001