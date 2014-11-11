require_relative 'gem_version'

module Dradis::Plugins::Mediawiki
  # Returns the version of the currently loaded Mediawiki as a
  # <tt>Gem::Version</tt>.
  def self.version
    gem_version
  end
end
