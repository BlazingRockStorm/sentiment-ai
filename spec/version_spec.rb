# frozen_string_literal: true
require 'spec_helper'

RSpec.describe SentimentAI::VERSION do
  it 'has a version number' do
    expect(SentimentAI::VERSION).not_to be nil
  end
end
