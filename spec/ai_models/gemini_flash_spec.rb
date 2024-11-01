# frozen_string_literal: true
require 'spec_helper'

RSpec.describe 'Using Gemini Flash model' do
  # TODO: Turn MOCK_API const into testable API
  let(:sentiment) { SentimentAI.new(:gemini_ai_flash, MOCK_API) }

  describe 'new model behaviours' do
    it 'model being called correctly' do
      expect(sentiment).to be_truthy
    end
  end

  describe 'analyze feature' do
    describe '#analyze_sentence' do
      xit 'return the sentiment of the sentence' do
        expect(sentiment.analyze_sentence('Delicious food')).to eq('Sentiment: Positive')
        expect(sentiment.analyze_sentence('Too noisy!!!')).to eq('Sentiment: Negative')
        expect(sentiment.analyze_sentence("I really don't know how to feel about Pokemon")).to eq('Sentiment: Neutral')
      end
    end
  end
end
