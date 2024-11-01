# frozen_string_literal: true

require 'sentiment_ai/version'
require 'openai'
require 'gemini-ai'

module SentimentAI
  def self.adapter= klass
    @klass = klass.capitalize
  end

  def self.new arg1,arg2
    const_get( @klass ).new arg1,arg2
  end

  class Base
    def initialize(model, token)
      @generative_ai = case model
            when :open_ai
              OpenAI::Client.new(access_token: token)
            when :gemini_ai_flash, :gemini_ai_pro
              model_type = model == :gemini_ai_flash ? 'gemini-flash' : 'gemini-pro'
              Gemini.new(
                credentials: {
                  service: 'generative-language-api',
                  api_key: token
                },
                options: { model: model_type, server_sent_events: true }
              )
            else
              raise ArgumentError
            end
    end
  end
end

SentimentAI.adapter = :base
