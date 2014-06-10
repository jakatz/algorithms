class Card
  attr_reader :value, :suit, :rank

  def initialize(value, suit)
    @value = value
    @suit = suit
    @rank = get_rank
  end

  protected
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

class Deck
  attr_reader :current_index, :ph
  attr_accessor :deck
  def initialize
    @deck = []
    @ph = []
    @current_index = 0
  end

  def self.suits
    [:clubs, :diamonds, :hearts, :spades]
  end

  def self.values
    [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
  end

  # Given a card, insert it on the bottom your deck
  def add_card(card)
    @ph << card
  end

  # Mix around the order of the cards in your deck
  def shuffle # You can't use .shuffle!
    @deck.size.times do |i|
      j = rand(@deck.size)
      @deck[i], @deck[j] = @deck[j], @deck[i]
    end
  end

  # Remove the top card from your deck and return it
  def deal_card
    i = @current_index
    card = @deck[i]
    @deck[i] = nil
    @current_index += 1
    check_array
    return card
  end

  def check_array
    if @deck[@current_index].nil?
      @deck = @ph
      @current_index = 0
      @ph = []
    end
  end

  # Reset this deck with 52 cards
  def create_52_card_deck
    Deck.suits.each do |suit|
      Deck.values.each do |value|
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



# ============================================

# class LinkedList
#   Class Node
#     attr_accessor :value, :next_node
#   end
#   def initialize
#     @first_node = nil
#     @last_node = nil
#   end

#   def add_item(item)
#     node = Node.new
#     node.value = item
#     node.next_node = nil

#     if (@first_node == nil)
#       @first_node = node
#     end

#     if (@last_node.nil?)
#       @last_node = node
#     else
#       @last_node.next_node = node
#       @last_node = node
#     end
#   end

#   def remove_item
#     node = @first_node
#     @first_node = @first_node.next_node
#     node.next_node = nil
#     return node.value
#   end
# end

# cards = [1, 2]

# first_card = LinkedList::Node.new
# first_card.value = 1
# second_card = LinkedList::Node.new
# second_card.value = 2

# first_card.new_node = second_card
# third_card = LinkedList::Node.new
# third_card.value = 3
# second_card.next_node = third_card

# puts first_card.value
# puts first_card.next_node.value
# puts first_card.next_node.next_node.value

