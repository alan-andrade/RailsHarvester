require 'oai'

class Harvester
  SITES = [
            #{
            #  :site   =>  "http://catarina.udlap.mx/u_dl_a/tales/oai/requestETD.jsp",
            #  :name   =>  "Universidad de las Americas Puebla, Electronic Thesis and Dissertation Archive "
            #},
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
    resumption_token  = nil
    
    SITES.each do |site|
      ## Connect with the Archives Provider
      client  = OAI::Client.new(site[:site])
      
      
      print "Client Name: #{site[:name]}\n"
      print "Retrieving Records...\n"
      
      begin  ## Loop will finish until there are no more resumption tokens
        ## Resumption Token Options for OAI
        options = {} 
        options[:resumption_token] = resumption_token unless resumption_token.nil?
        ##
        
        ## Retrieve Records from Provider
        begin
          records           = client.list_records(options)
        end rescue OAI::Exception
        ## Get the RT from the list_records verb
        resumption_token  = records.resumption_token rescue nil
        
        ## Iterate on the records
        records.each do |record|
          rec_to_db = Record.new
          if record.metadata
            record.metadata.elements.first.each_element do |element|          
              rec_to_db.send(element.name + "=", element.text) if rec_to_db.attributes.has_key? element.name
            end
            p rec_to_db.identifier
            rec_to_db.save
          end #if        
        end   #record
      end while not resumption_token.nil?
    end
    
  end
end

