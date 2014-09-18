require_relative "example_helper"

#text=gets.chomp.split
#puts text
#text = %w[My name is John .]
#puts text.class
text = File.read('sample.txt').gsub!("\n", "").split
#puts text
m = OpenNLP::English.named_entity_recognition_model(:money)
f = OpenNLP::NameFinder.new(m)
ranges = f.process(text)
locations = ranges.map { |r| text[r] }

pp locations
