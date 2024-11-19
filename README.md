# Sentiment-aI

✨ A gem that use Generative AI for data sentiment analysis ✨

The styling is to look like Sentimental, a tribute to the song Shunkan Sentimental by SCANDAL

## Installation

Install the gem and add to the application's Gemfile by executing:
```
$ bundle add sentiment-ai
```
If bundler is not being used to manage dependencies, install the gem by executing:
```
$ gem install sentiment-ai
```

## Compatibility

This gem is compatible with Ruby 3.1 or greater.

## Usage

Require it in you code:
```ruby
require "sentiment_ai"
```
Then use it like this:

```ruby
sentiment = SentimentAI.new(YOUR_PROVIDER,YOUR_API_KEY)
```

For example:
```ruby
sentiment = SentimentAI.new(:open_ai, OPEN_AI_KEY)
```

For the current version, the gem supports only OpenAI and Google Gemini.

After calling the provider, use:
```ruby
sentiment.analyze_sentence("I Love Ruby")
# => { :sentence => "I Love Ruby", :sentiment => "positive" }
```
For analyzing an array of sentence, use:
```ruby
array = ["I Love Ruby", "I use Ruby"]
sentiment.analyze_array(array)
# => [{ :sentence => "I Love Ruby", :sentiment => "positive" }, { :sentence => "I use Ruby", :sentiment => "neutral" }]
```
For analyzing a CSV file, use:
```ruby
sentiment.analyze_csv(csv_path, sentence_column, output_directory)
```
Assume that the CSV file is
```csv
comment
I love Ruby
I use Ruby
```
Analyze the file by calling: `sentiment.analyze_csv("path/to/example.csv", "comment", "output/directory")`. The output is:
```csv
comment,sentiment
I love Ruby, positive
I use Ruby, neutral
```
By default, the language used for the gem is English. If you want to use the other languages, Japanese for example, use:
```ruby
sentiment = SentimentAI.new(:open_ai, OPEN_AI_KEY, :ja)
sentiment.analyze_sentence("Rubyは世界一プログラミング言語")
# => { :sentence => "Rubyは世界一プログラミング言語", :sentiment => "肯定的" }
```
### Supported GenAI providers

| Language | Code |
|----------|------|
| OpenAI(GPT) | `:open_ai` |
| Google Gemini | `:gemini_ai_pro` |

### Supported languages

| Language | Code |
|----------|------|
| English  | `:en` |
| Vietnamese | `:vi` |
| Japanese | `:ja` |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).
