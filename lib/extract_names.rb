module BaseNlp

  class ExtractNames

    def self.names(named_entities)
      loc=[]
      names=named_entities.map{|x| loc<< x[0] if x[1].downcase=="person"}
    end

  end

end