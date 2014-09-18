require 'open-nlp'
module BaseNlp

  class GetLocation

    def self.extract_location(named_entities)
      loc=[]
      locations=named_entities.map{|x| loc<< x[0] if x[1]=="location"}
    end

 end

end