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
                            books: 0.0,
                            tf_idf: Hash.new(0.0),
                            highest: nil,
                            word_doc_count: Hash.new(0.0)
                          }
      books.each do |filename, tokens|
        book_hash = {
                      words: Hash.new(0.0),
                      word_count: 0.0,
                      highest: nil
                    }

        tokens.each do |token|
          if good_token?(token)
            @data[category][:words][token] += 1
            book_hash[:words][token] += 1
            book_hash[:word_count] += 1
            if book_hash[:words][token] > book_hash[:words][book_hash[:highest]]
              book_hash[:highest] = token
            end
          end
        end

        @data[category][:word_count] += book_hash[:word_count]
        @data[category][:books] += 1

        book_hash[:words].each do |word, count|
          @data[category][:tf_idf][word] = count/book_hash[:words][book_hash[:highest]]
          @data[category][:word_doc_count][word] += 1
        end
      end
    end

    @data.each do |category, category_hash|
      category_hash[:tf_idf].each do |word, count|
        idf = Math.log( category_hash[:words][category_hash[:highest]] / category_hash[:word_doc_count][word] )
        category_hash[:tf_idf][word] = category_hash[:tf_idf][word] * idf
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
puts "tf_idf " + category_hash[:tf_idf][token]
puts "words " + category_hash[:words][token]
puts "word_doc_count " + category_hash[:word_doc_count][token]

          if category_hash[:tf_idf][token] # > 0 && category_hash[:stop_words][token] <= 0
            word_count = category_hash[:tf_idf][token] # / (category_hash[:word_count] / category_hash[:books])

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
puts this_books_categories
    this_books_categories.each do |category, count|
      if count > highest_count
        highest = category
        highest_count = count
      end
    end

    highest
  end
end

