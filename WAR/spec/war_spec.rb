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
