require 'oai'

class Harvester
  SITES = [
            {
              :site   =>  "http://catarina.udlap.mx/u_dl_a/tales/oai/requestETD.jsp",
              :name   =>  "Universidad de las Americas Puebla, Electronic Thesis and Dissertation Archive "
            },
            {
              :site   =>  "http://ru.ffyl.unam.mx:8080/oai/request",
              :name   =>  "Repositorio de la Facultad de Filosofia y Letras. UNAM."
            },
            {
              :site   =>  "http://quijote.biblio.iteso.mx/oai/default.aspx",
              :name   =>  "Acervo General - ITESO"
            }            
          ]
          
  def self.harvest
    SITES.each do |site|
      client  = OAI::Client.new(site[:site])
      print "Client Name: #{site[:name]}\n"
      client.list_records.each do |record|
        print "Retrieving Records...\n"
        
        record_to_database  = Record.new
        
        record.metadata.elements.first.each_element do |element|
          #print "#{element.name}      ->  #{element.text}\n"
          
        end if record.metadata
        
      end
    end
  end
end

