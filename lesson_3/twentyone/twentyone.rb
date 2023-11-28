require 'pry'
require 'yaml'

MESSAGES = YAML.load_file('twentyone.yml')

CARD_RANKS = ('2'..'10').to_a + ['J', 'Q', 'K', 'A']
SUITS = ['D', 'C', 'H', 'S']

# formatting methods
def prompt(msg)
  if MESSAGES.keys.include?(msg)
    puts ">> #{MESSAGES[msg]}"
  else
    puts ">> #{msg}"
  end
end

def display_title(title="TWENTY-ONE")
  system 'clear'
  top_bottom_edge = '-' * (title.length + 2)

  puts "+#{top_bottom_edge}+"
  puts "| #{title} |"
  puts "+#{top_bottom_edge}+"
  puts ''
end

# game methods
def play_game
  # 1. Initialize deck
  deck = initialize_deck

  # 2. Deal cards to player and dealer
  cards = deal_cards(deck)

  # # 3. Player turn: hit or stay
  # #   - repeat until bust or "stay"
  play_player_turn(cards, deck)

  # 4. If player bust, dealer wins.
  if busted?(cards[:player])
    prompt 'player_bust'
    sleep(2)
    return
  else
    prompt 'stay'
  end

  # # 5. Dealer turn: hit or stay
  # #   - repeat until total >= 17
  play_dealer_turn(cards, deck)

  # # 6. If dealer bust, player wins.
  display_game(cards)
  return if busted?(cards[:dealer])

  # # 7. Compare cards and declare winner.
  winner = determine_winner(cards)
  display_result(winner)
  prompt "The winner is #{winner}!"
end

def display_game(cards)
  display_title

  puts "DEALER SCORE: #{calculate_total_value(cards[:dealer])}"
  display_cards(cards[:dealer])
  puts ''

  puts "PLAYER SCORE: #{calculate_total_value(cards[:player])}"
  display_cards(cards[:player])
  puts ''
end

# player_methods
def play_player_turn(cards, deck)
  display_game(cards)

  loop do
    choice = ask_hit_or_stay

    return if %w(s stay).include?(choice)

    prompt 'hit'
    cards[:player] << deck.pop
    display_game(cards)

    return if busted?(cards[:player])
  end
end

def ask_hit_or_stay
  prompt 'hit_or_stay'

  loop do
    answer = gets.chomp.downcase

    return answer if %w(h hit s stay).include?(answer)

    prompt 'invalid_hit_or_stay'
  end
end

# dealer_methods
def play_dealer_turn(cards, deck)
  while calculate_total_value(cards[:dealer]) < 17
    cards[:dealer] << deck.pop
    display_game(cards)
    sleep(2)
  end
end

# deck methods
def initialize_deck
  deck = []

  CARD_RANKS.each do |rank|
    SUITS.each { |suit| deck << [rank, suit] }
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

  { player: player_cards, dealer: dealer_cards }
end

def display_cards(cards)
  p cards
end

# calculation methods
def calculate_total_value(cards)
  ranks = cards.map(&:first)

  total = ranks.reduce(0) do |sum, rank|
    if rank == 'A'
      sum + 11
    elsif ['J', 'Q', 'K'].include?(rank)
      sum + 10
    else
      sum + rank.to_i
    end
  end

  ranks.count('A').times do
    total -= 10 if total > 21
  end

  total
end

def busted?(cards)
  calculate_total_value(cards) > 21
end

def determine_winner(cards)
  player_total = calculate_total_value(cards[:player])
  dealer_total = calculate_total_value(cards[:dealer])

  if busted?(cards[:player]) || dealer_total > player_total
    'Dealer'
  elsif busted?(cards[:dealer]) || player_total > dealer_total
    'Player'
  end
end

# result methods
def display_result(winner=nil)
  case winner
  when 'Player'
    prompt "Player wins!"
  when 'Dealer'
    prompt "Dealer wins!"
  else
    prompt "Push!"
  end

  sleep(2)
end

def play_again?
  prompt 'play_again'
  answered_yes?
end

def answered_yes?
  prompt 'yes_or_no'
  loop do
    answer = gets.chomp.downcase
    return %w(y yes).include?(answer) if %w(y yes n no).include?(answer)

    prompt 'invalid_yes_or_no'
  end
end

# -----------------------------------------------------------------------------

loop do
  play_game

  break unless play_again?
end

prompt 'goodbye'
