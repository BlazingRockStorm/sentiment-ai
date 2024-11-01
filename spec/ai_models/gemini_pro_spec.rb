# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'Using Gemini Pro model' do
  let(:sentiment) { SentimentAI.new(:gemini_ai_pro, MOCK_API) }

  describe 'new model behaviours' do
    it 'model being called correctly' do
      expect(sentiment).to be_truthy
    end
  end

  describe 'analyze feature' do
    describe '#analyze_sentence' do
      xit 'return the sentiment of the sentence' do
        expect(sentiment.analyze_sentence(:positive_sentence_example)).to eq('Sentiment: Positive')
        expect(sentiment.analyze_sentence(:negative_sentence_example)).to eq('Sentiment: Negative')
        expect(sentiment.analyze_sentence(:neutral_sentence_example)).to eq('Sentiment: Neutral')
      end
    end
  end
end
