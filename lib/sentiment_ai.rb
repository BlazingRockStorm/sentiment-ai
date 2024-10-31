# frozen_string_literal: true
require 'openai'
require 'gemini-ai'

class SentimentAI
  def initialize(model, token)
    @ai = case model
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

  def analyze_sentence(sentence)
    prompt = "Analyze the sentiment of the sentence given below.\n#{sentence}\nThe output should be in the format- Semtiment: Value"
    @result = client.stream_generate_content({
      contents: { role: 'user', parts: { text: prompt } },
      generationConfig: { temperature: 0 }
    })
  end
end
