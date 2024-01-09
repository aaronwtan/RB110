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
  scoreboard = initialize_scoreboard

  loop do
    player, dealer = play_round(scoreboard)
    display_round_result(player, dealer, scoreboard)
    if final_winner?(scoreboard)
      display_final_result(scoreboard)
      return
    end
  end
end

def ask_final_win_condition
  system 'clear'
  prompt 'ask_final_win_condition'

  loop do
    final_win_condition = gets.chomp

    if final_win_condition.empty?
      prompt 'default_win_condition'
      sleep(2)
      return 5
    elsif valid_number_string?(final_win_condition, '+')
      prompt "The first player to #{final_win_condition} will win the game."
      sleep(2)
      return final_win_condition.to_i
    end

    prompt 'invalid_number'
  end
end

def valid_number_string?(number_str, sign=nil)
  case sign
  when '+' then number_str =~ /^\d+$/ && number_str.to_i.positive?
  when '-' then number_str =~ /^\d+$/ && number_str.to_i.negative?
  else          number_str =~ /^\d+$/
  end
end

def play_round(scoreboard)
  # 1. Initialize deck
  deck = initialize_deck

  # 2. Deal cards to player and dealer
  player, dealer = initialize_players(deck)

  # 3. Player turn: hit or stay
  #    - repeat until bust or stay
  play_player_turn(player, dealer, deck, scoreboard)

  # 4. If player bust, dealer wins.
  #    - Otherwise continue to dealer's turn
  return [player, dealer] if busted?(player[:total])

  display_game(player, dealer, scoreboard, 'stay')

  # 5. Dealer turn: hit or stay
  #     - repeat until total >= 17
  play_dealer_turn(player, dealer, deck, scoreboard)

  # 6. If dealer bust, player wins.
  #    - Otherwise continue to compare cards
  return [player, dealer] if busted?(dealer[:total])

  display_game(player, dealer, scoreboard, 'dealer_stays')

  # # 7. Compare cards and declare winner.
  [player, dealer]
end

def display_game(player, dealer, scoreboard, msg_key=nil)
  display_title
  display_score(scoreboard)

  if dealer[:hole_card_hidden]
    puts "DEALER TOTAL: ?"
    display_cards_with_hidden_hole(dealer[:cards])
  else
    puts "DEALER TOTAL: #{dealer[:total]}"
    display_cards(dealer[:cards])
  end

  puts "PLAYER TOTAL: #{player[:total]}"
  display_cards(player[:cards])

  unless msg_key.nil?
    prompt msg_key
    sleep(2)
  end
end

def initialize_scoreboard
  { player: { score: 0 },
    dealer: { score: 0 },
    final_win_condition: ask_final_win_condition }
end

def display_score(scoreboard)
  puts "Player Wins: #{scoreboard[:player][:score]}"
  puts "Dealer Wins: #{scoreboard[:dealer][:score]}"
  puts ''
end

def initialize_players(deck)
  player_cards, dealer_cards = deal_cards(deck)
  player_total = calculate_total(player_cards)
  dealer_total = calculate_total(dealer_cards)

  player = { cards: player_cards, total: player_total }
  dealer = { cards: dealer_cards, total: dealer_total, hole_card_hidden: true }

  [player, dealer]
end

# player_methods
def play_player_turn(player, dealer, deck, scoreboard)
  loop do
    display_game(player, dealer, scoreboard)
    choice = ask_hit_or_stay

    if %w(h hit).include?(choice)
      player[:cards] << deck.pop
      player[:total] = calculate_total(player[:cards])
      display_game(player, dealer, scoreboard, 'hit')
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
def play_dealer_turn(player, dealer, deck, scoreboard)
  reveal_hole_card!(dealer)
  display_game(player, dealer, scoreboard, 'reveal_hole_card')

  while dealer[:total] < DEALER_STAY_CONDITION
    dealer[:cards] << deck.pop
    dealer[:total] = calculate_total(dealer[:cards])
    display_game(player, dealer, scoreboard, 'dealer_hits')
  end
end

def reveal_hole_card!(dealer)
  dealer[:hole_card_hidden] = false
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
  top_bottom_lines = "+-----+" * cards.size
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
  puts ''
end

def display_cards_with_hidden_hole(cards)
  shown_card_rank = cards.first.first
  shown_card_suit = cards.first.last

  top_bottom_lines = "+-----+" * cards.size
  upper_rank_lines = "#{format_rank_line(shown_card_rank, 'upper')}|*****|"
  suit_lines = "|  #{SUIT_TO_SYMBOL[shown_card_suit]}  ||*****|"
  lower_rank_lines = "#{format_rank_line(shown_card_rank, 'lower')}|*****|"

  puts top_bottom_lines
  puts upper_rank_lines
  puts suit_lines
  puts lower_rank_lines
  puts top_bottom_lines
  puts ''
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

# result methods
def determine_round_winner(player, dealer, scoreboard)
  if busted?(player[:total])
    update_score!(scoreboard, :dealer)
    :player_bust
  elsif busted?(dealer[:total])
    update_score!(scoreboard, :player)
    :dealer_bust
  elsif player[:total] > dealer[:total]
    update_score!(scoreboard, :player)
    :player
  elsif dealer[:total] > player[:total]
    update_score!(scoreboard, :dealer)
    :dealer
  else
    :tie
  end
end

def display_round_result(player, dealer, scoreboard)
  result = determine_round_winner(player, dealer, scoreboard)
  display_game(player, dealer, scoreboard)

  case result
  when :player_bust then prompt 'player_bust'
  when :dealer_bust then prompt 'dealer_bust'
  when :player      then prompt 'player_wins'
  when :dealer      then prompt 'dealer_wins'
  when :tie         then prompt 'tie'
  end

  sleep(2)
end

def final_winner?(scoreboard)
  !!determine_final_winner(scoreboard)
end

def determine_final_winner(scoreboard)
  if scoreboard[:player][:score] >= scoreboard[:final_win_condition]
    "Player"
  elsif scoreboard[:dealer][:score] >= scoreboard[:final_win_condition]
    "Dealer"
  end
end

def display_final_result(scoreboard)
  final_win_condition = scoreboard[:final_win_condition]
  final_winner = determine_final_winner(scoreboard)
  prompt "#{final_winner} is the first to #{final_win_condition} and is " \
         "the final winner of Twenty-One!"
  sleep(2)
end

def update_score!(scoreboard, winner)
  scoreboard[winner][:score] += 1
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
