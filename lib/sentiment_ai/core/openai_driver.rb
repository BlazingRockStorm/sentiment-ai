# frozen_string_literal: true

require 'openai'

module SentimentAI
  module Core
    class OpenAIDriver
      def initialize(api_key)
        @sentiment_ai = OpenAI::Client.new(access_token: api_key)
      end

      def analyze_sentence(sentence)
        text_request = "Analyze the sentiment of the sentence given below.\n#{sentence}\nThe output should be in the format- Semtiment: Value"
        @sentiment_ai.chat(
          parameters: {
            model: "gpt-4o",
            messages: [{ role: "user", content: text_request}],
            temperature: 0.7,
            stream: proc do |chunk, _bytesize|
              print chunk.dig("choices", 0, "delta", "content")
            end
          }
        )
      end
    end
  end
end
