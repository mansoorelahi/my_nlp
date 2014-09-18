require_relative "example_helper"

#text=gets.chomp.split
#puts text
#text = %w[My name is John .]
#puts text.class

class NamedEntityRecognition


  def initialize(data)
    @data = data
  end

  def location
#text = File.read('sample.txt').gsub!("\n", "").split
     text = @data.split
     puts text
    m = OpenNLP::English.named_entity_recognition_model(:location)
f = OpenNLP::NameFinder.new(m)
ranges = f.process(text)
locations = ranges.map { |r| text[r] }
  end
end
