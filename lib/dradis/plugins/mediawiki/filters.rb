module Dradis::Plugins::Mediawiki::Filters
  class FullTextSearch < Dradis::Plugins::Import::Filters::Base
    def query(params={})
      results = []

    end
  end
end

Dradis::Plugins::Import::Filters.add :mediawiki, :full_text_search, Dradis::Plugins::Mediawiki::Filters::FullTextSearch
