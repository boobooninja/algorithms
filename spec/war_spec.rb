require 'rspec'
# require 'pry-debugger'

require_relative '../war.rb'

describe "Card" do
  before(:each) do
    @card = Card.new(2, 2, :hearts)
  end

  it "initializes with rank, value, suit" do
    expect(@card).to be_a(Card)
  end

  it "#rank returns the card rank" do
    expect(@card.rank).to eq(2)
  end

  it "#value returns the card value" do
    expect(@card.value).to eq(2)
  end

  it "#suit returns the card suit" do
    expect(@card.suit).to eq(:hearts)
  end
end

describe "Deck" do
  before(:each) do
    @deck = Deck.new.create_52_card_deck
    @card = Card.new(2, 2, :hearts)
  end

  it "#add_card adds the given card to the bottom of the deck and returns the deck" do
    expect(@deck.add_card(@card)).to eq(@deck)
    expect(@deck.push_deck.last).to eq(@card)
  end

  it "#shuffle mixes the order of the cards and returns a deck" do
    first_card = @deck.shift_deck.first

    expect(@deck.shuffle.shift_deck.first).not_to eq(first_card)
  end

  it "#deal_card removes top card and returns it" do
    first_card = @deck.shift_deck.first

    expect(@deck.deal_card).to eq(first_card)
    expect(@deck.shift_deck.include?(first_card)).to eq(false)
  end

  it "#create_52_card_deck will reset the deck with 52 cards" do
    @deck.deal_card
    @deck.deal_card

    expect(@deck.shift_deck.length).to eq(52)
    expect(@deck.shift_deck_pointer).to eq(2)
  end
end

describe "Player" do
  before(:all) do
    @p1 = Player.new('p1')
    @p2 = Player.new('p2')
  end

  it "#initializes with a name and a hand" do
    expect(@p1).to be_a(Player)
    expect(@p1.hand).to be_a(Deck)
  end
end

describe "War" do
  before(:each) do
    @p1 = Player.new('p1')
    @p2 = Player.new('p2')
    @war = War.new(@p1, @p2)
  end

  it "#initializes with two players and sets deck" do
    expect(@war).to be_a(War)
    expect(@war.deck).to be_a(Deck)
  end

  it ".play_game will start a game and continue until there is a winner" do
    # War.stub(:play_turn).with(
    #   an_instance_of(Player),
    #   an_instance_of(Card),
    #   an_instance_of(Player),
    #   an_instance_of(Card) ) {
    #   {'player1' => [an_instance_of(Card), an_instance_of(Card)],
    #    'player2' => []} }

    # expect(War).to receive(:play_turn).any_number_of_times.with(
    #   kind_of(Player), kind_of(Card),
    #   kind_of(Player), kind_of(Card)) {
    #   {'player1' => [an_instance_of(Card), an_instance_of(Card)],
    #    'player2' => []} }

    expect( @war.play_game ).to be_a(String)
  end

  it ".play_stats_for returns the average plays to win" do
    expect(@war.play_stats_for).to be_a( String )
  end
end
