# Go to http://wiki.merbivore.com/pages/init-rb

use_orm :datamapper
use_test :rspec
use_template_engine :erb

# also load classes from lib
Merb.push_path(:lib, Merb.root_path("lib"), nil)

Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  c[:session_secret_key]  = '78581dedbb2e3fad89c6fb4f13f58127f7659cb0'  # required for cookie session store
  c[:session_id_key] = '_hypertime_session_id' # cookie session id key, defaults to "_session_id"
  
  # use new bundler exclusively
  c[:kernel_dependencies] = false
end

Merb::BootLoader.before_app_loads do
  require 'merb-slices'
  Merb::Slices::config[:repertoire_core][:layout] = :application
  
  require 'do_postgres'
  require 'dm-validations'
  require 'repertoire_core'
  DataObjects::Postgres.logger = DataObjects::Logger.new(STDOUT, 0)
end

Merb::BootLoader.after_app_loads do
end


# TODO.  should be in lib/string.rb, but merb bootloader is ignoring that

require 'iconv'

class String

  def to_permalink
    s = Iconv.iconv('ASCII//IGNORE//TRANSLIT', 'UTF-8', self).to_s
    s.gsub!(/\W+/, ' ')
    s.strip!
    s.downcase!
    s.gsub!(/\ +/, '-')
    s
  end
  
end


# TODO.  should be in lib/utilities, but merb bootloader is ignoring that

module Hypertime
  module Utilities

    def sanitize_tsquery(q)
      # TODO.  support +/- instead of & and |
      rules = {
        / /          => '|',          # separate words are 'or'
        / and /      => '&',          # allow english booleans
        / or /       => '|',          # ''
        /[^A-Za-z0-9\|\&]/ => ''      # delete all other spurious chars
      }

      q = q.strip
      rules.each do |pattern, result|
        q = q.gsub(pattern, result)
      end
      q
    end
  end


end