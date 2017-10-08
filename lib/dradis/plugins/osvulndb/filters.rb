module Dradis::Plugins::Osvulndb::Filters
  class Search < Dradis::Plugins::Import::Filters::Base
    def query(params = {})
      q = /#{params[:query]}/i
      results = []

      db_path = Dradis::Plugins::Osvulndb::Engine.settings.db_path
      Dir.glob("#{db_path}/*.json").each do |db_file|
        data = JSON.parse(File.read(db_file))
        desc = data['description'].join(' ')

        has_tag = !data['tags'].nil? and data['tags'].include?(params[:query].downcase)
        if data['title'].match(q) or desc.match(q) or has_tag
          results << Dradis::Plugins::Import::Result.new(
            title: data['title'],
            description: fields_from_json(data)
          )
        end
      end

      results
    end

    def fields_from_json(data)
      dradis_fields = "#[Title]#\n#{data['title']}\n\n"
      
      if data['description'].kind_of?(Array)
        dradis_fields += "#[Description]#\n#{data['description'].join(' ')}\n\n"
      else
        dradis_fields += "#[Description]#\n#{data['description']}\n\n"
      end

      dradis_fields += "#[Severity]#\n#{data['severity']}\n\n"
      dradis_fields += "#[Remediation Effort]#\n#{data['fix']['effort']}\n\n"
      
      if data['fix']['guidance'].kind_of?(Array)
        dradis_fields += "#[Fix]#\n#{data['fix']['guidance'].join(' ')}\n\n"
      else
        dradis_fields += "#[Fix]#\n#{data['fix']['guidance']}\n\n"
      end

      unless data['wasc'].nil?
        wasc = "#[WASC]#\n"
        data['wasc'].each do |wasc_id|
          wasc += "* #{wasc_id}\n"
        end
        dradis_fields += "#{wasc}\n"
      end

      unless data['cwe'].nil?
        cwe = "#[CWE]#\n"
        data['cwe'].each do |cwe_id|
          cwe += "* \"#{cwe_id}\":https://cwe.mitre.org/data/definitions/#{cwe_id}.html\n"
        end
        dradis_fields += "#{cwe}\n"
      end

      unless data['owasp_top_10'].nil?
        owasp = "#[OWASP]#\n"
        data['owasp_top_10'].each do |owasp_id|
          owasp += "* #{owasp_id}\n"
        end
        dradis_fields += "#{owasp}\n"
      end

      unless data['references'].nil?
        refs = "#[References]#\n"
        data['references'].each do |ref|
          refs += "* #{ref['url']}\n"
        end
        dradis_fields += "#{refs}\n"
      end

      unless data['tags'].nil?
        dradis_fields += "#[Tags]#\n#{data['tags'].join(',')}\n\n"
      end

      dradis_fields
    end
  end
end

Dradis::Plugins::Import::Filters.add :osvulndb, :pattern, Dradis::Plugins::Osvulndb::Filters::Search
