class OsvulndbTasks < Thor
  namespace 'dradis:plugins:osvulndb'

  desc 'search QUERY', 'perform a general search against a VulnDB repository'
  def search(query)
    require 'config/environment'

    results = Dradis::Plugins::Osvulndb::Filters::Search.new.query(query: query)

    puts "\nVulnDB Search\n============="
    puts "#{results.size} results\n\n"

    results.each do |record|
      puts "#{record.description}"
      puts "=============\n\n"
    end
  end
end
