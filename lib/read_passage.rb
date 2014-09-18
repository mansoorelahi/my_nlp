module BaseNlp


 class ReadPassage

  def read_doc
    OpenNLP.load
    text = File.read('sample.txt').gsub!("\n", "")

    tokenizer   = OpenNLP::TokenizerME.new
    segmenter   = OpenNLP::SentenceDetectorME.new
    ner_models  = ['person', 'time', 'money','location']

    ner_finders = ner_models.map do |model|
      OpenNLP::NameFinderME.new("en-ner-#{model}.bin")
    end

    sentences = segmenter.sent_detect(text)
    named_entities = []

    sentences.each do |sentence|
      tokens = tokenizer.tokenize(sentence)
      ner_models.each_with_index do |model,i|
        finder = ner_finders[i]
        name_spans = finder.find(tokens)
        name_spans.each do |name_span|
          start = name_span.get_start
          stop  = name_span.get_end-1
          slice = tokens[start..stop].to_a
          named_entities << [slice, model]
        end
      end
    end
    named_entities
  end
 end
end