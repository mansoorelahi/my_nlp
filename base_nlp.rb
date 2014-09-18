require "lib/get_location"
require "lib/read_passage"
require "lib/extract_names"

require 'open-nlp'
module BaseNlp


   class DataExtracter

     def initialize
       data = ReadPassage.new
       @processed_data = data.read_doc
     end

     def get_loc
       get_location=GetLocation.extract_location(@processed_data).compact.first.uniq
     end

     def get_name
       names=ExtractNames.names(@processed_data).compact.first.uniq
     end

   end




end

loc= BaseNlp::DataExtracter.new
puts loc.get_name