require_relative "example_helper"

model = OpenNLP::English.pos_tagging_model
tagger = OpenNLP::POSTagger.new(model)
text = %w[who am I  ? ]
#result = tagger.process(text)
question = ["WP", "WRB", "WDT", ".",""].to_set

if text.include?("name") && result.any? { |x| question.include?(x) }
  puts "asking for name"
end

location = %w[where are you from ?]

result = tagger.process(location)
pp result

#location
if  result.any? { |x| question.include?(x) }
  puts "asking for location"
end

result[0] # => NNP
result[1] # => VBZ
result[2] # => JJ

pp result
