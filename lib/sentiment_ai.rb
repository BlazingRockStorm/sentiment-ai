# frozen_string_literal: true

require 'sentiment_ai/version'
require 'sentiment_ai/core/gemini_driver'
require 'sentiment_ai/core/openai_driver'

module SentimentAI
  def self.adapter=(klass)
    @klass = klass.capitalize
  end

  def self.new(arg1, arg2)
    const_get(@klass).new arg1, arg2
  end

  class Base
    def initialize(model, api_key)
      @generative_ai = case model
                       when :open_ai
                         Core::OpenAIDriver.new(api_key)
                       when :gemini_ai_pro
                         Core::GeminiDriver.new(api_key)
                       else
                         raise ArgumentError
                       end
    end

    def analyze_sentence(sentence)
      puts @generative_ai.analyze_sentence(sentence)
    end
  end
end

SentimentAI.adapter = :base
