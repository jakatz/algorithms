require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../war.rb'

describe Card do
  describe "#initialize" do
    it "is initialized with a value and a suit" do
      card = Card.new(2, :clubs)
      expect(card.value).to eq(2)
      expect(card.suit).to eq(:clubs)

      card2 = Card.new(14, :diamonds)
      expect(card2.value).to eq(14)
      expect(card2.suit).to eq(:diamonds)
    end
  end
end

describe Deck do
  describe "#initialize" do
    it "is initialized with an empty array" do
      deck = Deck.new
      expect(deck.deck.size).to eq(0)
    end
  end
end
