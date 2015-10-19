class Card

  attr_accessor :face, :suit, :value

  def initialize(face, suit)
    self.suit = suit
    self.face = face.to_s
    if face == "Ace"
      self.value = 11
    elsif face == "King" || face == "Queen" || face == "Jack"
      self.value = 10
    else
      self.value = face.to_i
    end
  end

end
