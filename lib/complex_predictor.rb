require_relative 'predictor'
require 'set'

class ComplexPredictor < Predictor
  # Public: Trains the predictor on books in our dataset. This method is called
  # before the predict() method is called.
  #
  # Returns nothing.
  def train!
    @data = {}

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
          if category_hash[:words][token]
            word_count = category_hash[:words][token] / (category_hash[:word_count] / category_hash[:books])

            if word_count > highest_count
              highest = category
              highest_count = word_count
            end
          end
        end

        if highest
          this_books_categories[highest] += 1
        end
      end
    end

    highest = nil
    highest_count = 0

    this_books_categories.each do |category, count|
      if count > highest_count
        highest = category
        highest_count = count
      end
    end

    highest
  end
end

