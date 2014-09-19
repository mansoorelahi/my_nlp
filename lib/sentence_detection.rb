require_relative "example_helper"


class SentenceDetection

  def initialize(data)
    @data = data
  end

  def sentence_count
    model = OpenNLP::English.sentence_detection_model
    detector = OpenNLP::SentenceDetector.new(model)
    result = detector.process(@data)
  end
end