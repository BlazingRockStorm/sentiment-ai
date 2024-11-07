# frozen_string_literal: true

require 'sentiment_ai/version'
require 'sentiment_ai/core/gemini_driver'
require 'sentiment_ai/core/openai_driver'
require 'i18n'

I18n.load_path += Dir[File.expand_path("config/locales") + "/*.yml"]
I18n.default_locale = :en

module SentimentAI
  def self.adapter=(klass)
    @klass = klass.capitalize
  end

  def self.new(*args)
    const_get(@klass).new(*args)
  end

  class Base
    def initialize(model, api_key, language = :en)
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
      @generative_ai.analyze_sentence(sentence)
    end
  end
end

SentimentAI.adapter = :base
