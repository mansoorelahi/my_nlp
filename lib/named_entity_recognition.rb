require_relative "example_helper"

class NamedEntityRecognition


  def initialize(data)
    @data = data
  end

  def location
    text = @data.split
    m = OpenNLP::English.named_entity_recognition_model(:location)
    f = OpenNLP::NameFinder.new(m)
    ranges = f.process(text)
    locations = ranges.map { |r| text[r] }
  end

  def person
    text = @data.split
    m = OpenNLP::English.named_entity_recognition_model(:person)
    f = OpenNLP::NameFinder.new(m)
    ranges = f.process(text)
    persons = ranges.map { |r| text[r] }
  end

  def money
    text = @data.split
    m = OpenNLP::English.named_entity_recognition_model(:money)
    f = OpenNLP::NameFinder.new(m)
    ranges = f.process(text)
    money = ranges.map { |r| text[r] }
  end

  def pos
    model = OpenNLP::English.pos_tagging_model
    tagger = OpenNLP::POSTagger.new(model)
    text = @data.split
    pos = tagger.process(text)
  end
end
