require_relative 'deck.rb'

class Game

  attr_accessor :deck, :player, :dealer

  def initialize
    self.deck = Deck.new.shuffle
    self.player = []
    self.dealer = []
    2.times do |x|
      player << x = deck.shift
      dealer << x = deck.shift
    end
  end

  def player_hit
    player << deck.shift
  end

  def player_hand_value
    player.collect{|x| x.value}.inject(:+)
  end

  def dealer_hit
    dealer << deck.shift
  end

  def dealer_hand_value
    dealer.collect{|x| x.value}.inject(:+)
  end

  def dealer_draw
    if dealer_hand_value < 16
      until dealer_hand_value >=16
        dealer_hit
      end
      puts "The dealer has drawn."
    else
      puts "The dealer stays."
    end
  end

  def round
    puts "The dealer is showing the #{dealer.first.face} of #{dealer.first.suit}."
    puts "You have the #{player.first.face} of #{player.first.suit} and the #{player.last.face} of #{player.last.suit}, worth #{player_hand_value.to_s} total.\nWould you like to hit or stay? (h/s)"
    if STDIN.gets.chomp.downcase == "h"
      player_hit
      puts "You drew the #{player.last.face} of #{player.last.suit}."
    else
      puts "You're staying at #{player_hand_value.to_s}"
    end
    if player_hand_value == 21
      puts "You're at 21-- YOU WIN!"
      new_game?
    end
    dealer_draw
    check_player_hand
  end

  def check_player_hand
    if player_hand_value > 21
      puts "You're now at #{player_hand_value.to_s}-- BUST. DEALER WINS!"
      new_game?
    else
      until player_hand_value >= 21
        puts "Would you like to hit or stay? (h/s)"
        if STDIN.gets.chomp.downcase == "h"
          player_hit
          puts "You drew the #{player.last.face} of #{player.last.suit}."
          puts "You're at #{player_hand_value.to_s}."
          if player_hand_value >=21
            compare_hands
          end
        else
          puts "You're staying at #{player_hand_value.to_s}."
          compare_hands
        end
      end
    end
  end

  def compare_hands
    if player_hand_value < dealer_hand_value
      if dealer_hand_value <= 21
        puts "You drew #{player_hand_value.to_s} but the dealer drew #{dealer_hand_value.to_s}-- DEALER WINS."
      else
        puts "Dealer busts-- YOU WIN!"
      end
    elsif player_hand_value > dealer_hand_value
      if player_hand_value < 21
        puts "You drew #{player_hand_value.to_s} to the dealer's #{dealer_hand_value.to_s}--YOU WIN!"
      elsif player_hand_value == 21
        puts "Blackjack-- YOU WIN!"
      else
        puts "Bust-- DEALER WINS."
      end
    else
      puts "TIE-- YOU WIN!"
    end
    new_game?
  end

  def new_game?
    puts "Would you like to play again? (y/n)"
    if STDIN.gets.chomp.downcase == "y"
      Game.new.play
    else
      puts "Thanks for playing!"
      exit
    end
  end

  def play
    puts "Welcome to blackjack! Press [enter] to play."
    STDIN.gets
    if player_hand_value == 21
      puts "You drew blackjack-- YOU WIN!"
      new_game?
    else
      round
      new_game?
    end
  end

end

Game.new.play
