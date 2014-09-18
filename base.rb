require 'open-nlp'
OpenNLP.load

sent = "The death of the poet was kept from his poems."
tokenizer = OpenNLP::SimpleTokenizer.new

tokens = tokenizer.tokenize(sent).to_a
puts tokens.inspect