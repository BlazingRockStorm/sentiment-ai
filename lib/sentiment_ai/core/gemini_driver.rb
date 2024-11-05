# frozen_string_literal: true
require 'gemini-ai'

module SentimentAI
  module Core
    class GeminiDriver
      def initialize(model, api_key)
        @sentiment_ai = case model
              when :gemini_ai_flash, :gemini_ai_pro
                model_type = model == :gemini_ai_flash ? 'gemini-flash' : 'gemini-pro'
                Gemini.new(
                  credentials: {
                    service: 'generative-language-api',
                    api_key: api_key
                  },
                  options: { model: model_type, server_sent_events: true }
                )
              else
                raise ArgumentError
              end
      end
      def analyze_sentence(sentence)
        text_request = "Analyze the sentiment of the sentence given below.\n#{sentence}\nThe output should be in the format- Semtiment: Value"
      end
    end
  end
end