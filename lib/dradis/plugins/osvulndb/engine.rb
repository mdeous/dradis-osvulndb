module Dradis::Plugins::Osvulndb
  class Engine < ::Rails::Engine
    isolate_namespace Dradis::Plugins::Osvulndb

    include ::Dradis::Plugins::Base
    provides :import
    description 'VulnDB Repository'

    addon_settings :osvulndbimport do
      settings.default_db_path = '/opt/vulndb'
      settings.default_db_lang = 'en'
    end
  end
end
