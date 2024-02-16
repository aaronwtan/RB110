# We started working on a card game but got stuck.
# Check out why the code below raises a TypeError.

# Once you get the program to run and produce a sum,
# you might notice that the sum is off: It's lower than it should be. Why is that?

cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

deck = { :hearts   => cards.clone,
         :diamonds => cards.clone,
         :clubs    => cards.clone,
         :spades   => cards.clone }

def score(card)
  case card
  when :ace   then 11
  when :king  then 10
  when :queen then 10
  when :jack  then 10
  else card
  end
end

# Pick one random card per suit

player_cards = []
deck.keys.each do |suit|
  cards = deck[suit]
  cards = cards.shuffle!
  player_cards << cards.pop
end

# Determine the score of the remaining cards in the deck

sum = deck.reduce(0) do |sum, (_, remaining_cards)|
  scores = remaining_cards.map do |card|
    score(card)
  end

  sum += scores.sum
end

puts sum

# The values of each key in the deck hash is the same cards array
# that was initialized on line 1. Every mutating method is
# thus reflected in each value of the key-value pairs in deck
