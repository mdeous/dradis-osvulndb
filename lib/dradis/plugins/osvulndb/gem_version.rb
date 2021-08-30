module Dradis
  module Plugins
    module Osvulndb

      # Returns the version of the currently loaded Osvulndb plugin as a <tt>Gem::Version</tt>
      def self.gem_version
        Gem::Version.new VERSION::STRING
      end

      module VERSION
        MAJOR = 2
        MINOR = 0
        TINY = 0
        PRE = nil

        STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
      end

    end
  end
end
