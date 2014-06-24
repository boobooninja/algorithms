require_relative 'predictor'
require 'set'

class ComplexPredictor < Predictor
  # Public: Trains the predictor on books in our dataset. This method is called
  # before the predict() method is called.
  #
  # Returns nothing.
  def train!
    @data = {}

    # {
    #   philosophy: {
    #     words: {'angst' => 4, 'christianity' => 7},
    #     word_count: 1000,
    #     books: 10,
    #   }
    # }

    @all_books.each do |category, books|
      @data[category] ||= {
                            words: Hash.new(0.0),
                            word_count: 0.0,
                            books: 0.0
                          }
      books.each do |filename, tokens|
        tokens.each do |token|
          if good_token?(token)
            @data[category][:words][token] += 1
            @data[category][:word_count] += 1
          end
        end

        @data[category][:books] += 1
      end
    end

    # max_word = nil
    # max_count = 0
    # @data.each do |category, category_hash|

    # end
  end

  # Public: Predicts category.
  #
  # tokens - A list of tokens (words).
  #
  # Returns a category.
  def predict(tokens)

    this_books_categories = {}

    @data.each do |category, category_hash|
      this_books_categories[category] = 0.0
    end

    tokens.each do |token|
      if good_token?(token)
        highest = nil
        highest_count = 0.0

        @data.each do |category, category_hash|
          # if category_hash[:words][token]
            word_count = category_hash[:words][token] / category_hash[:books]
            highest = category if word_count > highest_count
            highest_count = category_hash[:words][token]
          # end
        end

        if highest
          this_books_categories[highest] += 1
        end
      end
    end

    highest = nil
    highest_count = 0
    good_token_count = 0
    this_books_categories.each do |category, count|
puts "#{category} : #{count} : #{count / @data[category][:books]}"
      if count > highest_count
        highest = category
        highest_count = count
      end
      good_token_count += count
    end
puts "highest: #{highest}"
    highest


    minimum_category = nil
    minimum_distance = 999999999999

    @data.each do |category, counts|
      average_words_per_book = counts[:word_count] / counts[:books]
      difference = (good_token_count - average_words_per_book).abs

      if difference < minimum_distance
        minimum_category = category
        minimum_distance = difference
      end
    end

    minimum_category
puts "minimum_category : #{minimum_category}"

    if this_books_categories[highest] < this_books_categories[minimum_category]
      highest
    else
      minimum_category
    end

  end
end

