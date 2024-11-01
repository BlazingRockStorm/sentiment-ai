# frozen_string_literal: true

require_relative 'lib/sentiment_ai/version'

Gem::Specification.new do |spec|
  spec.name        = 'sentiment-ai'
  spec.version     = SentimentAI::VERSION
  spec.summary     = 'AI Sentiment Gem'
  spec.description = 'A gem that use Generative AI for data sentiment analysis'
  spec.authors     = ['Quan Hoang']
  spec.email       = 'quanhoangd129@gmail.com'
  spec.files       = Dir['lib/sentiment_ai.rb', 'lib/sentiment_ai/*.rb']
  spec.homepage    = 'https://rubygems.org/gems/sentiment-ai'
  spec.license     = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['source_code_uri'] = 'https://github.com/BlazingRockStorm/sentiment-ai'

  spec.add_development_dependency 'gemini-ai', '~> 4.2'
  spec.add_development_dependency 'ruby-openai', '~> 6.0'
end
