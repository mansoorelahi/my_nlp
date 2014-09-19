require_relative 'example_helper'

class Chunking


  def initialize(data)
    @data = data
  end

  def chunker
    text = @data
    tokenizer = OpenNLP::Tokenizer.new(OpenNLP::English.tokenization_model)
    tagger    = OpenNLP::POSTagger.new(OpenNLP::English.pos_tagging_model)
    chunker   = OpenNLP::Chunker.new(OpenNLP::English.chunking_model)
    tokens = tokenizer.process(text)
    tags = tagger.process(tokens)
    chunks = chunker.process(tokens, tags)
    chunks =  tokens.zip(chunks)

  end
end



