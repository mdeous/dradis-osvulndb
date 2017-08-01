require_relative 'gem_version'

module Dradis::Plugins::Osvulndb
  # Returns the version of the currently loaded Osvulndb as a
  # <tt>Gem::Version</tt>.
  def self.version
    gem_version
  end
end
