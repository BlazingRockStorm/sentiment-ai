# frozen_string_literal: true

# Only use Gemini Pro
require 'gemini-ai'
require 'faraday'

module SentimentAI
  module Core
    class GeminiDriver
      def initialize(api_key)
        @sentiment_ai =
          Gemini.new(
            credentials: {
              service: 'generative-language-api',
              api_key: api_key
            },
            options: { model: 'gemini-pro', server_sent_events: true }
          )
      end

      def analyze_sentence(sentence)
        text_request = "Analyze the sentiment of the sentence given below.\n#{sentence}\nThe output should be in the format- Semtiment: Value"
        @sentiment_ai.stream_generate_content({
                                                contents: { role: 'user', parts: { text: text_request } },
                                                generationConfig: { temperature: 0 }
                                              })
      end
    end
  end
end
