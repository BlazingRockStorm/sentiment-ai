# frozen_string_literal: true

require 'sentiment_ai/version'
require 'sentiment_ai/core/gemini_driver'
require 'sentiment_ai/core/openai_driver'
require 'i18n'
require 'csv'

I18n.load_path += Dir["#{File.expand_path('config/locales')}/*.yml"]
I18n.default_locale = :en

module SentimentAI
  def self.adapter=(klass)
    @klass = klass.capitalize
  end

  def self.new(*args)
    const_get(@klass).new(*args)
  end

  class Base
    def initialize(provider, api_key, language = :en)
      I18n.locale = language
      @generative_ai = case provider
                       when :open_ai
                         Core::OpenAIDriver.new(api_key)
                       when :gemini_ai_pro
                         Core::GeminiDriver.new(api_key)
                       else
                         raise ArgumentError
                       end
    end

    def analyze_sentence(sentence)
      sentiment = @generative_ai.analyze_sentence(sentence)
      { sentence: sentence, sentiment: sentiment }
    end

    def positive_check(sentence)
      sentiment_bool = @generative_ai.positive_check(sentence)
      { sentence: sentence, positive: sentiment_bool == 'true' }
    end

    def analyze_array(array)
      array.map { |sentence| analyze_sentence(sentence) }
    end

    def analyze_csv(input_csv_path, sentence_column, output_directory)
      csv_data = CSV.read(input_csv_path, headers: true)
      unless csv_data.headers.include?(sentence_column)
        raise ArgumentError,
              "#{sentence_column} column not found in CSV file"
      end

      File.open("#{output_directory}/output.csv", 'w') do |file|
        file.write("sentence,sentiment\n")
        csv_data.each do |row|
          result = analyze_sentence(row[sentence_column])
          file.write "#{result[:sentence]},#{result[:sentiment]}\n"
        end
      end
    end
  end
end

SentimentAI.adapter = :base
