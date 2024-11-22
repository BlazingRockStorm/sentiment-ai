# frozen_string_literal: true

require 'anthropic'

module SentimentAI
  module Core
    class AnthropicDriver
      def initialize(api_key)
        @sentiment_ai = Anthropic::Client.new(access_token: api_key)
      end

      def analyze_sentence(sentence)
        text_request = I18n.t('prompt.sentence', sentence: sentence)

        @sentiment_ai.messages(
          parameters: {
            model: 'claude-3-haiku-20240307',
            messages: [
              { 'role': 'user', 'content': text_request }
            ],
            max_tokens: 1000
          }
        )
      end

      def positive_check(sentence)
        text_request = I18n.t('prompt.positive_check', sentence: sentence)

        @sentiment_ai.messages(
          parameters: {
            model: 'claude-3-haiku-20240307',
            messages: [
              { 'role': 'user', 'content': text_request }
            ],
            max_tokens: 1000
          }
        )
      end
    end
  end
end
