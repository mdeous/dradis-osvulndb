module Dradis::Plugins::Mediawiki

  class Engine < ::Rails::Engine
    isolate_namespace Dradis::Plugins::Mediawiki

    include ::Dradis::Plugins::Base
    provides :import
    description 'Import entries from an external MediaWiki'

    addon_settings :wikiimport do
      settings.host      = 'localhost'
      settings.port      = 80
      settings.path      = 'mediawiki/api.php'
      settings.fields    = 'Title,Impact,Probability,Description,Recommendation'
    end
  end

end
