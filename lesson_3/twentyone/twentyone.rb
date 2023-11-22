DEALER_STAY_VALUE = 17

# formatting methods
def prompt(msg)
  puts ">> #{msg}"
end

# deck methods
def initialize_deck
  [['2', 'H'], ['A', 'D']]
end

def deal_cards(deck)
  player_cards = deck.pop
  dealer_cards = deck.pop

  [player_cards, dealer_cards]
end

# calculation methods
def calculate_total_cards_value(cards)
  
end

def busted?(cards)

end

def determine_winner(player_cards, dealer_cards)

end

# result methods


# -----------------------------------------------------------------------------

# 1. Initialize deck
deck = initialize_deck
# deck -> stack-like data structure represented by 2D nested-array

# 2. Deal cards to player and dealer
player_cards, dealer_cards = deal_cards(deck)

# 3. Player turn: hit or stay
#   - repeat until bust or "stay"
loop do
  prompt "Hit or stay? (h/s)"
  answer = gets.chomp

  break if %w(s stay).include?(answer) || busted?(player_cards)

  player_cards << deck.pop
end

# 4. If player bust, dealer wins.
if busted?(player_cards)
  winner = 'Dealer'
end

# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
while calculate_total_cards_value(dealer_cards) < DEALER_STAY_VALUE
  dealer_cards << deck.pop
end

# 6. If dealer bust, player wins.
if busted?(dealer_cards)
  winner = 'Player'
end

# 7. Compare cards and declare winner.
winner = determine_winner(player_cards, dealer_cards)
