require 'pry'
require 'yaml'

MESSAGES = YAML.load_file('twentyone.yml')

CARD_NUMBERS = ('2'..'10').to_a + ['J', 'Q', 'K', 'A']
SUITS = ['D', 'C', 'H', 'S']

# formatting methods
def prompt(msg)
  if MESSAGES.keys.include?(msg)
    puts MESSAGES[msg]
  else
    puts ">> #{msg}"
  end
end

# deck methods
def initialize_deck
  deck = []

  CARD_NUMBERS.each do |value|
    SUITS.each { |suit| deck << [value, suit] }
  end

  shuffle!(deck)
  deck
end

def shuffle!(deck)
  deck.each_index do |index|
    random_card_index = rand(52)
    deck[index], deck[random_card_index] = deck[random_card_index], deck[index]
  end
end

def deal_cards(deck)
  player_cards = []
  dealer_cards = []

  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end

  [player_cards, dealer_cards]
end

def display_cards(cards)

end

# calculation methods
def calculate_total_value(cards)
  numbers = cards.map(&:first)

  total = numbers.reduce(0) do |sum, number|
    if number == 'A'
      sum + 11
    elsif ['J', 'Q', 'K'].include?(number)
      sum + 10
    else
      sum + number.to_i
    end
  end

  numbers.count { |number| number == 'A' }.times do
    total -= 10 if total > 21
  end

  total
end

def busted?(cards)
  calculate_total_value(cards) > 21
end

def determine_winner(player_cards, dealer_cards)
  player_total = calculate_total_value(player_cards)
  dealer_total = calculate_total_value(dealer_cards)

  if player_total > dealer_total
    'Player'
  elsif dealer_total > player_total
    'Dealer'
  else
    'Push'
  end
end

# result methods
def display_result(winner)
  case winner
  when 'Player'
    prompt "Player wins!"
  when 'Dealer'
    prompt "Dealer wins!"
  else
    prompt "Push!"
  end
end

# -----------------------------------------------------------------------------

# 1. Initialize deck
deck = initialize_deck

# deck -> stack-like data structure represented by 2D nested array

# 2. Deal cards to player and dealer
player_cards, dealer_cards = deal_cards(deck)
puts "Dealer cards: #{dealer_cards}"
puts "Score: #{calculate_total_value(dealer_cards)}"
puts "Player cards: #{player_cards}"
puts "Score: #{calculate_total_value(player_cards)}"

# # 3. Player turn: hit or stay
# #   - repeat until bust or "stay"
loop do
  prompt 'hit_or_stay'
  answer = gets.chomp

  break if %w(s stay).include?(answer)

  player_cards << deck.pop
  puts "Player cards: #{player_cards}"
  puts "Score: #{calculate_total_value(player_cards)}"

  break if busted?(player_cards)
end

# 4. If player bust, dealer wins.
if busted?(player_cards)
  winner = 'Dealer'
end

# # 5. Dealer turn: hit or stay
# #   - repeat until total >= 17
while calculate_total_value(dealer_cards) < 17
  puts "Dealer cards: #{dealer_cards}"
  puts "Score: #{calculate_total_value(dealer_cards)}"
  dealer_cards << deck.pop
end

# # 6. If dealer bust, player wins.
puts "Dealer cards: #{dealer_cards}"
puts "Score: #{calculate_total_value(dealer_cards)}"
if busted?(dealer_cards)
  winner = 'Player'
end

# # 7. Compare cards and declare winner.
winner = determine_winner(player_cards, dealer_cards)
display_result(winner)
prompt "The winner is #{winner}!"
