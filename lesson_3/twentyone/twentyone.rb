require 'pry'
require 'yaml'

MESSAGES = YAML.load_file('twentyone.yml')

CARD_RANKS = ('2'..'10').to_a + ['J', 'Q', 'K', 'A']
SUITS = ['D', 'C', 'H', 'S']

SUIT_SYMBOLS = ["\u2666", "\u2663", "\u2665", "\u2660"].map do |unicode|
  unicode.encode('utf-8')
end

SUIT_TO_SYMBOL = SUITS.zip(SUIT_SYMBOLS).to_h

BUST_CONDITION = 21
DEALER_STAY_CONDITION = 17

# formatting methods
def prompt(msg)
  if MESSAGES.keys.include?(msg)
    puts ">> #{MESSAGES[msg]}"
  else
    puts ">> #{msg}"
  end
end

def display_welcome
  display_title('Welcome to Twenty-One!')
  sleep(2)
end

def display_title(title="TWENTY-ONE")
  system 'clear'
  top_bottom_edge = '-' * (title.length + 2)

  puts "+#{top_bottom_edge}+"
  puts "| #{title} |"
  puts "+#{top_bottom_edge}+"
  puts ''
end

def convert_unicode(unicode)
  unicode.encode('utf-8')
end

# game methods
def play_game
  # 1. Initialize deck
  deck = initialize_deck

  # 2. Deal cards to player and dealer
  player, dealer = initialize_players(deck)

  # 3. Player turn: hit or stay
  #    - repeat until bust or stay
  play_player_turn(player, dealer, deck)

  # 4. If player bust, dealer wins.
  #    - Otherwise continue to dealer's turn
  return display_result(player, dealer) if busted?(player[:total])

  display_game(player, dealer, 'stay')

  # 5. Dealer turn: hit or stay
  #     - repeat until total >= 17
  play_dealer_turn(player, dealer, deck)

  # 6. If dealer bust, player wins.
  #    - Otherwise continue to compare cards
  return display_result(player, dealer) if busted?(dealer[:total])

  display_game(player, dealer, 'dealer_stays')

  # # 7. Compare cards and declare winner.
  display_result(player, dealer)
end

def display_game(player, dealer, msg_key=nil)
  display_title

  puts "DEALER SCORE: #{dealer[:total]}"
  display_cards(dealer[:cards])
  puts ''

  puts "PLAYER SCORE: #{player[:total]}"
  display_cards(player[:cards])
  puts ''

  unless msg_key.nil?
    prompt msg_key
    sleep(1.5)
  end
end

def initialize_players(deck)
  player_cards, dealer_cards = deal_cards(deck)
  player_total = calculate_total(player_cards)
  dealer_total = calculate_total(dealer_cards)

  player = { cards: player_cards, total: player_total }
  dealer = { cards: dealer_cards, total: dealer_total }

  [player, dealer]
end

# player_methods
def play_player_turn(player, dealer, deck)
  loop do
    display_game(player, dealer)
    choice = ask_hit_or_stay

    if %w(h hit).include?(choice)
      player[:cards] << deck.pop
      player[:total] = calculate_total(player[:cards])
      display_game(player, dealer, 'hit')
    end

    return if %w(s stay).include?(choice) || busted?(player[:total])
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
def play_dealer_turn(player, dealer, deck)
  while dealer[:total] < DEALER_STAY_CONDITION
    dealer[:cards] << deck.pop
    dealer[:total] = calculate_total(dealer[:cards])
    display_game(player, dealer, 'dealer_hits')
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

  [player_cards, dealer_cards]
end

def display_cards(cards)
  number_of_cards = cards.size

  top_bottom_lines = "+-----+" * number_of_cards
  upper_rank_lines = ''
  suit_lines = ''
  lower_rank_lines = ''

  cards.each do |rank, suit|
    upper_rank_lines << format_rank_line(rank, 'upper')
    suit_lines << "|  #{SUIT_TO_SYMBOL[suit]}  |"
    lower_rank_lines << format_rank_line(rank, 'lower')
  end

  puts top_bottom_lines
  puts upper_rank_lines
  puts suit_lines
  puts lower_rank_lines
  puts top_bottom_lines
end

def format_rank_line(rank, position)
  case position
  when 'upper'
    case rank.length
    when 1 then "|#{rank}    |"
    when 2 then "|#{rank}   |"
    end
  when 'lower'
    case rank.length
    when 1 then "|    #{rank}|"
    when 2 then "|   #{rank}|"
    end
  end
end

# calculation methods
def calculate_total(cards)
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

  ranks.count('A').times { total -= 10 if total > BUST_CONDITION }

  total
end

def busted?(total)
  total > BUST_CONDITION
end

def determine_winner(player, dealer)
  if busted?(player[:total])
    :player_bust
  elsif busted?(dealer[:total])
    :dealer_bust
  elsif player[:total] > dealer[:total]
    :player
  elsif dealer[:total] > player[:total]
    :dealer
  else
    :tie
  end
end

# result methods
def display_result(player, dealer)
  display_game(player, dealer)
  result = determine_winner(player, dealer)

  case result
  when :player_bust
    prompt 'player_bust'
  when :dealer_bust
    prompt 'dealer_bust'
  when :player
    prompt 'player_wins'
  when :dealer
    prompt 'dealer_wins'
  when :tie
    prompt 'tie'
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
display_welcome

loop do
  play_game

  break unless play_again?
end

prompt 'goodbye'
