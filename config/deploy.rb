set :rake, 'bundle exec rake'
set :stages, %w(production)
set :default_stage, 'production'
set :application, 'Coreboot_Builder'
set :repo_url,    'git@github.com:coreboot-builder/coreboot-builder.git'
set :ssh_options, { forward_agent: true, port: 24006 }
set :use_sudo,    false
set :linked_dirs, fetch(:linked_dirs, []).push(*%w{public/uploads log})
