# frozen_string_literal: true

class SentimentAI
  def initialize(model, token)
    @ai = case model
          when :open_ai
            depends_on 'openai'

            OpenAI::Client.new(access_token: token)
          when :gemini_ai_flash, :gemini_ai_pro
            depends_on 'gemini-ai'

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

  def self.analyze
    puts 'TO DO: The analyze function'
  end
end
