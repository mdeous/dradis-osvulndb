module Dradis::Plugins::Osvulndb
  class Engine < ::Rails::Engine
    isolate_namespace Dradis::Plugins::Osvulndb

    include ::Dradis::Plugins::Base
    provides :import
    description 'Import entries from a VulnDB repository'

    addon_settings :osvulndbimport do
      settings.default_db_path   = '/pentest/tools/vulndb-data/db'
    end
  end
end
