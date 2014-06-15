require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../war.rb'

describe Card do
  describe "#initialize" do
    it "is initialized with a value and a suit" do
      c1 = Card.new(2, :clubs)
      expect(c1.value).to eq(2)
      expect(c1.suit).to eq(:clubs)
      expect(c1.rank).to eq(2)

      c2 = Card.new(14, :diamonds)
      expect(c2.value).to eq(14)
      expect(c2.suit).to eq(:diamonds)
      expect(c2.rank).to eq("A")
    end
  end
end

describe Deck do
  describe "#initialize" do
    it "is initialized with an empty array" do
      d = Deck.new
      expect(d.deck.size).to eq(0)
    end
  end

  describe ".suits" do
    it "contains an array of the 4 suits as symbols" do
      expect(Deck.suits).to eq([:clubs, :diamonds, :hearts, :spades])
    end
  end

  describe ".values" do
    it "contains an array of all card values 2-14" do
      expect(Deck.values). to eq([2,3,4,5,6,7,8,9,10,11,12,13,14])
    end
  end

  describe "#create_52_card_deck" do
    it "adds 52 cards objects to the deck" do
      d1 = Deck.new
      d1.create_52_card_deck
      expect(d1.deck.size).to eq(52)

      d1.create_52_card_deck
      expect(d1.deck.size).to eq(104)
    end
  end

  # d = Deck.new
  # d.count_cards == 0
  # d.add_card(5)
  # d.add_card(10)
  # d.count_cards == 2
  # d.deal_card == 5
  # d.deal_card == 10
  # d.deal_card == nil

  describe "#deal_card" do
    it "removes a card from the deck and replaces it with nil" do
      d1 = Deck.new
      d1.create_52_card_deck
      expect(d1.current_index).to eq(0)
      d1.deal_card
      expect(d1.deck.size).to eq(52)
      expect(d1.deck[d1.current_index - 1]).to be_nil
      expect(d1.current_index).to eq(1)
    end

    it "swaps with a placeholder deck when all of the positions of the array are nil" do
      d1 = Deck.new
      d1.create_52_card_deck
      51.times do
        temp = d1.deal_card
        d1.add_card(temp)
      end
      expect(d1.deal_card).to be_an_instance_of(Card)
      expect(d1.deck.include?(nil)).to eq(false)
      expect(d1.deck.size).to eq(51)
      expect(d1.current_index) == 0
    end

    it "returns a card" do
      deck = Deck.new
      deck.create_52_card_deck
      expect(deck.deal_card).to be_an_instance_of(Card)
    end
  end

  describe "#shuffle" do
    it "shuffles the deck in a random order" do
      d1 = Deck.new
      d1.create_52_card_deck
      d1.shuffle
      expect(d1.deck.size).to eq(52)
    end
  end
end

describe Player do
  describe "#initialize" do
    it "is initialized with a name and an empty hand" do
      player_1 = Player.new("Salt")
      player_2 = Player.new("Pepper")

      expect(player_1.name).to eq("Salt")
      expect(player_1.hand.deck.size).to eq(0)
      expect(player_2.name).to eq("Pepper")
      expect(player_2.hand.deck.size).to eq(0)
    end
  end
end

describe War do
  describe "#initialize" do
    it "creates a main deck, and deals all its cards out evenly to the players" do
      w = War.new("Salt", "Pepper")
      expect(w.player1.hand.deck.size).to eq(26)
      expect(w.player2.hand.deck.size).to eq(26)
    end

    # it "can create a game with multiple decks" do

    # end
  end

  describe "#play_round" do
    it "plays a round of War" do
      w = War.new("Salt", "Pepper")
      w.play_round
      expect(w.main_deck.deck.size).to eq(0)
      expect((w.player1.hand.deck.size) + (w.player2.hand.deck.size)).to eq(52)
    end
  end

  describe "#complete_game" do
    it "plays a whole game of war" do
      w = War.new("Salt", "Pepper")
      w.complete_game
      expect(w.player1.has_more_cards? == false || w.player2.has_more_cards? == false).to eq(true)
      #add test for full deck
    end
  end
end

describe WarAPI do

end
