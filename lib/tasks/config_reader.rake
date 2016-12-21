require 'rake'

namespace :config do
  desc "Read config files"
  task :read => :environment do
    c = ConfigReader.new
    o = OptionsReader.new
    c.run
    o.run
  end
end
