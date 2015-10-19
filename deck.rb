require_relative 'card.rb'

class Deck
  attr_accessor :cards

  def initialize
    possible_cards = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
    possible_suits = %w(Clubs Spades Diamonds Hearts)
    self.cards = []
    possible_suits.each do |suit|
      possible_cards.each do |face|
        self.cards << Card.new(face, suit)
      end
    end
  end

  def shuffle
    self.cards.shuffle
  end

end
