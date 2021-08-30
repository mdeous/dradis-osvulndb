module Dradis::Plugins::Osvulndb::Filters
  class Search < Dradis::Plugins::Import::Filters::Base
    def read_ref(basedir, ref)
      refpath = ref.gsub(/#\/files\//, "")
      desc_path = "#{basedir}/#{refpath}.md"

      File.read(desc_path).strip
    end
    
    def query(params = {})
      q = params[:query].downcase
      results = []

      db_path = Dradis::Plugins::Osvulndb::Engine.settings.db_path
      db_lang = Dradis::Plugins::Osvulndb::Engine.settings.db_lang
      db_basedir = "#{db_path}/db/#{db_lang}"
      Dir.glob("#{db_basedir}/*.json").each do |db_file|
        data = JSON.parse(File.read(db_file))
        title = data['title']
        desc =  read_ref(db_basedir, data['description']['$ref'])

        title_match = title.downcase.include?(q)
        desc_match = desc.downcase.include?(q)
        tags_match = data['tags'].nil? ? false : data['tags'].include?(q)
        if title_match or desc_match or tags_match
          fix = read_ref(db_basedir, data['fix']['guidance']['$ref'])
          results << Dradis::Plugins::Import::Result.new(
            title: title,
            description: fields_from_json(data, desc, fix)
          )
        end
      end

      results
    end

    def fields_from_json(vulndata, desc, fix)
      dradis_fields = "#[Title]#\n#{vulndata['title']}\n\n"
      dradis_fields += "#[Description]#\n#{desc}\n\n"
      dradis_fields += "#[Severity]#\n#{vulndata['severity']}\n\n"
      dradis_fields += "#[Remediation Effort]#\n#{vulndata['fix']['effort']}\n\n"
      dradis_fields += "#[Fix]#\n#{fix}\n\n"

      unless vulndata['wasc'].nil?
        wasc = "#[WASC]#\n"
        vulndata['wasc'].each do |wasc_id|
          wasc += "* #{wasc_id}\n"
        end
        dradis_fields += "#{wasc}\n"
      end

      unless vulndata['cwe'].nil?
        cwe = "#[CWE]#\n"
        vulndata['cwe'].each do |cwe_id|
          cwe += "* \"#{cwe_id}\":https://cwe.mitre.org/data/definitions/#{cwe_id}.html\n"
        end
        dradis_fields += "#{cwe}\n"
      end

      unless vulndata['owasp_top_10'].nil?
        owasp = "#[OWASP]#\n"
        vulndata['owasp_top_10'].each do |owasp_year, owasp_ids|
          owasp_ids.each do |owasp_id|
            owasp += "* Top 10 #{owasp_year}: A#{owasp_id}\n"
          end
        end
        dradis_fields += "#{owasp}\n"
      end

      unless vulndata['references'].nil?
        refs = "#[References]#\n"
        vulndata['references'].each do |ref|
          refs += "* #{ref['url']}\n"
        end
        dradis_fields += "#{refs}\n"
      end

      unless vulndata['tags'].nil?
        dradis_fields += "#[Tags]#\n#{vulndata['tags'].join(',')}\n\n"
      end

      dradis_fields.gsub('`', '@')
    end
  end
end

Dradis::Plugins::Import::Filters.add :osvulndb, :pattern, Dradis::Plugins::Osvulndb::Filters::Search
