# This class is complete. You do not need to alter this
class Card
  # Rank is the rank of the card, 2-10, J, Q, K, A
  # Value is the numeric value of the card, so J = 11, A = 14
  # Suit is the suit of the card, Spades, Diamonds, Clubs or Hearts

  attr_reader :rank, :value, :suit

  def initialize(rank, value, suit)
    @rank = rank
    @value = value
    @suit = suit
  end
end

# TODO: You will need to complete the methods in this class
class Deck
  attr_reader :push_deck, :shift_deck, :shift_deck_pointer

  def initialize
    @push_deck  = [ ]
    @shift_deck = [ ]
    @shift_deck_pointer = 0
  end

  # Given a card, insert it on the bottom your deck
  def add_card(card)
    @push_deck << card
    self
  end

  # Mix around the order of the cards in your deck
  def shuffle # You can't use .shuffle!
    x = 0
    total = @shift_deck.length

    total.times do
      random = Random.rand(total - 1)
      @shift_deck[x], @shift_deck[random] = @shift_deck[random], @shift_deck[x]
      x += 1
    end
    self
  end

  # Remove the top card from your deck and return it
  def deal_card
    card = @shift_deck[@shift_deck_pointer]

    if card == nil
      swap_decks
      deal_card
    else
      @shift_deck[@shift_deck_pointer] = nil
      @shift_deck_pointer += 1
      card
    end
  end

  # Reset this deck with 52 cards
  def create_52_card_deck
    @push_deck  = [ ]
    @shift_deck = [ ]
    @shift_deck_pointer = 0

    [:hearts, :spades, :diamonds, :clubs].each do |suit|
      (2..10).to_a.each do |num|
        @shift_deck << Card.new(num, num, suit)
      end

      [['J',11],['Q',12],['K',13],['A',14]].each do |face, num|
        @shift_deck << Card.new(face, num, suit)
      end
    end

    self.shuffle
  end

  def reset
    @push_deck  = [ ]
    @shift_deck = [ ]
    @shift_deck_pointer = 0
  end

  def empty?
    @shift_deck.last.nil? && @push_deck.last.nil?
  end

  private

  def swap_decks
    @shift_deck = @push_deck.dup
    @push_deck  = [ ]
    @shift_deck_pointer = 0
  end
end

# You may or may not need to alter this class
class Player
  attr_reader :name, :hand

  def initialize(name)
    @name = name
    @hand = Deck.new
  end
end

module WarAPI
  # This method will take a card from each player and
  # return a hash with the cards that each player should receive
  def self.play_turn(player1, card1, player2, card2)
    if card1.value > card2.value
      {'player1' => [card1, card2], 'player2' => []}
    elsif card2.value > card1.value || Random.rand(100).even?
      {'player1' => [], 'player2' => [card2, card1]}
    else
      {'player1' => [card1, card2], 'player2' => []}
    end
  end
end

class War
  # extend WarAPI

  attr_reader :deck, :player1, :player2
  attr_accessor :play_count

  def initialize(player1, player2)
    @deck = Deck.new.create_52_card_deck
    @player1 = player1
    @player2 = player2
    @play_count = 0
    # You will need to shuffle and pass out the cards to each player
    deal_cards
  end

  # You will need to play the entire game in this method using the WarAPI
  def play_game
    deck.create_52_card_deck
    @player1.hand.reset
    @player2.hand.reset
    @play_count = 0
    deal_cards

    begin
      return_hash = WarAPI.play_turn(player1, player1.hand.deal_card, player2, player2.hand.deal_card)

      @play_count += 1

      return_hash['player1'].each do |card|
        player1.hand.add_card(card)
      end

      return_hash['player2'].each do |card|
        player2.hand.add_card(card)
      end
    end until player1.hand.empty? || player2.hand.empty?

    if player2.hand.empty?
      str = "#{player1.name} won the game!"
      puts str
      str
    else
      str = "#{player2.name} won the game!"
      puts str
      str
    end
  end

  def play_stats_for(game_count = 100)
    game_count_array = [ ]

    game_count.times do
    # 10.times do
      play_game

      game_count_array << @play_count
    end

    avg_turns = game_count_array.inject(0.0) {|sum, num| sum + num} / game_count_array.size

    str = "Average turns to win: #{avg_turns}"
    puts str
    str
  end

  private

  def deal_cards
    26.times do
      player1.hand.add_card( deck.deal_card )
      player2.hand.add_card( deck.deal_card )
    end
  end
end
