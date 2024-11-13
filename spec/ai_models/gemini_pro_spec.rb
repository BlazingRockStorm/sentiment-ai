# frozen_string_literal: true

require 'spec_helper'
require 'dotenv/load'

RSpec.describe 'Using Gemini Pro model' do
  let(:sentiment) { SentimentAI.new(:gemini_ai_pro, ENV['GEMINI_API']) }
  let(:japanese_sentiment) { SentimentAI.new(:gemini_ai_pro, ENV['GEMINI_API'], :ja) }

  describe 'new model behaviours' do
    it 'model being called correctly' do
      expect(sentiment).to be_truthy
    end
  end

  describe 'analyze sentence in another language' do
    describe '#analyze_sentence' do
      it 'return the sentiment of the sentence' do
        expect(japanese_sentiment.analyze_sentence('うまい！')).to eq({ sentence: 'うまい！', sentiment: '肯定的' })
        expect(japanese_sentiment.analyze_sentence('不愉快')).to eq({ sentence: '不愉快', sentiment: '否定的' })
        expect(japanese_sentiment.analyze_sentence('休暇はまずまずでした。')).to eq({ sentence: '休暇はまずまずでした。', sentiment: '中立' })
      end
    end
  end

  describe 'analyze feature' do
    describe '#analyze_sentence' do
      it 'return the sentiment of the sentence' do
        expect(sentiment.analyze_sentence('Delicious food')).to eq({ sentence: 'Delicious food',
                                                                     sentiment: 'positive' })
        expect(sentiment.analyze_sentence('Too noisy!!!')).to eq({ sentence: 'Too noisy!!!', sentiment: 'negative' })
        expect(sentiment.analyze_sentence("I really don't know how to feel about Pokemon")).to eq({
                                                                                                    sentence: "I really don't know how to feel about Pokemon", sentiment: 'neutral'
                                                                                                  })
      end
    end

    describe '#analyze_array' do
      let(:array) { ['Delicious food', 'Too noisy!!!', "I really don't know how to feel about Pokemon"] }
      let(:result_array) do
        [{ sentence: 'Delicious food', sentiment: 'positive' },
         { sentence: 'Too noisy!!!', sentiment: 'negative' },
         { sentence: "I really don't know how to feel about Pokemon", sentiment: 'neutral' }]
      end

      it 'return the sentiments of all sentences in the array' do
        expect(sentiment.analyze_array(array)).to eq(result_array)
      end
    end
  end
end
