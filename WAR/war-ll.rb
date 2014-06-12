class LinkedList
  attr_reader :node_count

  class Node
    attr_accessor :value, :next_node

    def initialize(value)
      @value = value
      @next_node = nil
    end
  end

  def initialize
    @first_node = nil
    @last_node = nil

    @node_count = 0
  end

  def push(item)
    node = Node.new(item)

    if (@first_node == nil)
      @first_node = node
    end

    if (@last_node.nil?)
      @last_node = node
    else
      @last_node.next_node = node
      @last_node = node
    end

    @node_count += 1
  end

  def unshift
    node = @first_node
    @first_node = @first_node.next_node
    node.next_node = nil
    @node_count -= 1
    return node.value
  end
end

class Deck
  attr_reader :deck

  def initialize
    @deck = LinkedList.new
  end

# Remove the top card from your deck and return it
  def deal_card
    @deck.unshift
  end

  # Given a card, insert it on the bottom your deck
  def add_card(card)
    @deck.push(card)
  end

  # Mix around the order of the cards in your deck
  def shuffle
    sd = []
    (@deck.node_count).times do
      sd << deal_card
    end

    sd.size.times do |i|
      j = rand(sd.size)
      sd[i], sd[j] = sd[j], sd[i]
    end

    sd.each do |card|
      add_card(card)
    end
  end

  def self.suits
    [:clubs, :diamonds, :hearts, :spades]
  end

  def self.values
    [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
  end

  def create_52_card_deck
    Deck.suits.each do |suit|
      Deck.values.each do |value|
        add_card(Card.new(value, suit))
      end
    end
  end
end

class Card
  attr_reader :value, :suit, :rank

  def initialize(value, suit)
    @value = value
    @suit = suit
    @rank = get_rank
  end

  def get_rank
    case @value
    when 11
      @rank = "J"
    when 12
      @rank = "Q"
    when 13
      @rank = "K"
    when 14
      @rank = "A"
    else
      @rank = @value
    end
  end
end

class Player
  attr_reader :name, :hand

  def initialize(name)
    @name = name
    @hand = Deck.new
  end

  def has_more_cards?
    if @hand.deck.size == 0
      return false
    else
      return true
    end
  end

end


class War
  attr_reader :player1, :player2, :main_deck

  @@rounds_played = 0

  def initialize(player1, player2, deck_number = 1)
    @main_deck = Deck.new
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)

    deck_number.times do
      @main_deck.create_52_card_deck
      @main_deck.shuffle
    end

    ((@main_deck.deck.size)/2).times do
      temp = @main_deck.deal_card
      @player1.hand.add_card(temp)
    end

    ((@main_deck.deck.size)/2).times do
      temp = @main_deck.deal_card
      @player2.hand.add_card(temp)
    end

    @player1.hand.swap_decks
    @player2.hand.swap_decks
    ##find alternate solution for this ^
  end

  # You will need to play the entire game in this method using the WarAPI
  def play_round
    p1_turn = @player1.hand.deal_card
    p2_turn = @player2.hand.deal_card
    rewards = WarAPI.play_turn(@player1, p1_turn, @player2, p2_turn)

    rewards.each do |key, value|
      value.each { |card| key.hand.add_card(card)}
    end

    @@rounds_played += 1
  end

  def complete_game
    # until !@player1.has_more_cards? || !@player2.has_more_cards?
    while @player1.has_more_cards? && @player2.has_more_cards?
      play_round
    end

    if @player1.has_more_cards?
      puts "#{@player1.name} won after #{@@rounds_played} rounds!"
    else
      puts "#{@player2.name} won after #{@@rounds_played} rounds!"
    end
  end

end

class WarAPI
  def self.play_turn(player1, card1, player2, card2)
    if card1.value > card2.value
      {player1 => [card1, card2], player2 => []}
    elsif card2.value > card1.value
      {player1 => [], player2 => [card2, card1]}
    else
      tie(player1, card1, player2, card2)
    end
  end

  def self.tie(player1, card1, player2, card2)
    p1_tie_cards = [card1]
    p2_tie_cards = [card2]

    4.times do
      p1_tie_cards << player1.hand.deal_card
      p2_tie_cards << player2.hand.deal_card
    end

    p1_tie_cards.compact!
    p2_tie_cards.compact!

    loot = (p1_tie_cards.dup << p2_tie_cards).flatten!

    p1_last_card = p1_tie_cards.last
    p2_last_card = p2_tie_cards.last

    if p1_last_card.value > p2_last_card.value
        {player1 => loot, player2 => []}
    elsif p2_last_card.value > p1_last_card.value
        {player1 => [], player2 => loot}
    else
      tie(player1, p1_last_card, player2, p2_last_card)
    end
  end
end
