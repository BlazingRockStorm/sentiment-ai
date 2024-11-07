# frozen_string_literal: true

# Only use Gemini Pro
require 'gemini-ai'

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
        text_request = I18n.t('prompt', sentence: sentence)

        response = @sentiment_ai.stream_generate_content({
                                                           contents: { role: 'user', parts: { text: text_request } },
                                                           generationConfig: { temperature: 0 }
                                                         })
        extract_candidates(response)
      end

      private

      def extract_candidates(candidates)
        candidates.map { |response| response.dig('candidates', 0, 'content', 'parts') }
                  .map { |parts| parts.map { |part| part['text'] }.join }
                  .join
      end
    end
  end
end
