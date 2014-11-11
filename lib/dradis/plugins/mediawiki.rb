module Dradis
  module Plugins
    module Mediawiki
      # class Configuration < Core::Configurator
      #   configure :namespace => 'wikiimport'
      #   setting :host, :default => 'localhost'
      #   setting :port, :default => 80
      #   setting :path, :default => '/mediawiki/api.php'
      #   setting :fields, :default => 'Title,Impact,Probability,Description,Recommendation'
      # end
    end
  end
end

require 'dradis/plugins/mediawiki/engine'
require 'dradis/plugins/mediawiki/filters'
require 'dradis/plugins/mediawiki/version'
