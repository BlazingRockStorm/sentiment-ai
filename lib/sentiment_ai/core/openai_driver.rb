# frozen_string_literal: true

require 'openai'

module SentimentAI
  module Core
    class OpenAIDriver
      def initialize(_model, api_key)
        @sentiment_ai = OpenAI::Client.new(access_api_key: api_key)
      end

      def analyze_sentence
        puts 'TO DO: The analyze function'
      end
    end
  end
end
