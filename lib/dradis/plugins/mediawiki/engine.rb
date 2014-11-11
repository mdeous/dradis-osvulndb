module Dradis::Plugins::Mediawiki

  class Engine < ::Rails::Engine
    isolate_namespace Dradis::Plugins::Mediawiki

    include ::Dradis::Plugins::Base
    provides :import
    description 'Import entries from an external MediaWiki'
  end

end
