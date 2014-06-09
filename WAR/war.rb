# This class is complete. You do not need to alter this
class Card
  attr_reader :value, :suit
  # Value is the numeric value of the card, so J = 11, A = 14
  # Suit is the suit of the card, Spades, Diamonds, Clubs or Hearts
  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end

# TODO: You will need to complete the methods in this class
class Deck
  attr_accessor :deck
  def initialize
    @deck = [] # Determine the best way to hold the cards
  end

  def self.suits
    [:clubs, :diamonds, :hearts, :spades]
  end

  def self.values
    [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
  end

  # Given a card, insert it on the bottom your deck
  def add_card(card)

  end

  # Mix around the order of the cards in your deck
  def shuffle # You can't use .shuffle!

  end

  # Remove the top card from your deck and return it
  def deal_card

  end

  # Reset this deck with 52 cards
  def create_52_card_deck
    self.suits.each do |suit|
      @values.each do |value|
        @deck << Card.new(value, suit)
      end
    end
  end

end

# You may or may not need to alter this class
class Player
  def initialize(name)
    @name = name
    @hand = Deck.new
  end
end


class War
  def initialize(player1, player2)
    @deck = Deck.new
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)
    # You will need to shuffle and pass out the cards to each player
  end

  # You will need to play the entire game in this method using the WarAPI
  def play_game
    # WarAPI.play_turn()
  end
end


class WarAPI
  # This method will take a card from each player and
  # return a hash with the cards that each player should receive
  def self.play_turn(player1, card1, player2, card2)
    if card1.value > card2.value
      {player1 => [card1, card2], player2 => []}
    elsif card2.value > card1.value || Rand(100).even?
      {player1 => [], player2 => [card2, card1]}
    else
      {player1 => [card1, card2], player2 => []}
    end
  end
end
