# require 'pry'
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
DEFAULT_WINS = 5

RULES_PT1 = <<-MSG
---------- RULES ----------
=> OBJECTIVE:
=> The goal of Twenty-One is to try to get as close to 21 as possible,
=> without going over. If you go over 21, it's a "bust" and an
=> immediate loss.

=> SETUP:
=> The game consists of a "dealer" and a "player". Both participants
=> are initially dealt 2 cards. The player can see both their cards,
=> but can initially see only the first of the dealer's cards,
=> with the second card (the "hole" card) hidden from the player.

=> CARD VALUES:
=> Card numbers 2-10 are worth their face value. Jacks, queens,
=> and kings are each worth 10. Aces are worth either 1 or 11,
=> depending on the player's hand: an ace is counted as 11 if
=> it does not cause the hand's value to exceed 21; otherwise,
=> it is counted as 1.

MSG

RULES_PT2 = <<-MSG
---------- RULES ----------
=> GAMEPLAY:
=> The player goes first and can choose to "hit" to add more cards
=> to their hand, or "stay" to keep their current hand. If their
=> hand's total exceeds 21, the player busts and loses.

=> If the player stays without busting, the dealer's turn begins.
=> The dealer must hit until their total hand is at least 17, at which
=> point they must stay. If the dealer busts, the player wins.

=> If both the player and dealer stay without busting, then the total value
=> of each hand is compared and the winner is the one with the highest
=> value. If the values are the same, it's a tie, resulting in a "push".

MSG

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

def format_header(msg)
  "-----#{msg}-----"
end

def format_footer(length)
  '-' * length
end

def convert_unicode(unicode)
  unicode.encode('utf-8')
end

# settings methods
def configure_settings
  final_win_condition = ask_final_win_condition
  players = [:player, :dealer]
  ask_rules

  { players: players, final_win_condition: final_win_condition }
end

def ask_final_win_condition
  system 'clear'
  prompt 'ask_final_win_condition'

  loop do
    final_win_condition = gets.chomp

    if final_win_condition.empty?
      prompt 'default_win_condition'
      sleep(2)
      return DEFAULT_WINS
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

def ask_rules
  system 'clear'
  prompt 'ask_rules'

  display_rules if answered_yes?
end

def display_rules
  loop do
    system 'clear'
    puts RULES_PT1
    ask_player_ready

    system 'clear'
    puts RULES_PT2

    prompt 'ask_rules_again'

    return unless answered_yes?
  end
end

def ask_player_ready
  prompt 'ready'
  gets
end

# game methods
def play_game(settings)
  system 'clear'
  prompt 'begin_game'
  ask_player_ready
  scoreboard = initialize_scoreboard(settings[:players],
                                     settings[:final_win_condition])

  loop do
    player, dealer = play_round(scoreboard)
    display_round_result(player, dealer, scoreboard)
    if final_winner?(scoreboard)
      display_final_result(scoreboard)
      return
    end

    update_round!(scoreboard)
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
  display_info(dealer)
  display_info(player)

  unless msg_key.nil?
    prompt msg_key
    sleep(2)
  end
end

def initialize_scoreboard(players, final_win_condition)
  { players.first => { score: 0 },
    players.last => { score: 0 },
    :round => 1,
    :final_win_condition => final_win_condition }
end

def display_score(scoreboard)
  header = format_header("ROUND #{scoreboard[:round]}")
  footer = format_footer(header.length)

  puts header
  puts "Player Wins: #{scoreboard[:player][:score]}"
  puts "Dealer Wins: #{scoreboard[:dealer][:score]}"
  puts footer
  puts "First to #{scoreboard[:final_win_condition]} wins!"
  puts ''
end

def display_info(player)
  if player[:hole_hidden].nil?
    puts "PLAYER TOTAL: #{player[:total]}"
  elsif player[:hole_hidden]
    puts "DEALER TOTAL: ?"
  else
    puts "DEALER TOTAL: #{player[:total]}"
  end

  display_cards(player)
end

def initialize_players(deck)
  player_cards, dealer_cards = deal_cards(deck)
  player_total = calculate_total(player_cards)
  dealer_total = calculate_total(dealer_cards)

  player = { cards: player_cards, total: player_total }
  dealer = { cards: dealer_cards, total: dealer_total, hole_hidden: true }

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
  dealer[:hole_hidden] = false
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

def display_cards(player)
  cards = player[:cards]
  initial_card_rank = cards[0][0]
  initial_card_suit = cards[0][1]

  top_bottom_lines = "+-----+" * cards.size
  middle_lines = [format_rank_line(initial_card_rank, 'upper'),
                  "|  #{SUIT_TO_SYMBOL[initial_card_suit]}  |",
                  format_rank_line(initial_card_rank, 'lower')]

  append_middle_lines(player, middle_lines)

  puts top_bottom_lines
  puts middle_lines
  puts top_bottom_lines
  puts ''
end

def append_middle_lines(player, middle_lines)
  upper_rank_lines = middle_lines[0]
  suit_lines = middle_lines[1]
  lower_rank_lines = middle_lines[2]

  player[:cards][1..-1].each do |rank, suit|
    if player[:hole_hidden]
      middle_lines.each { |lines| lines << "|*****|" }
    else
      upper_rank_lines << format_rank_line(rank, 'upper')
      suit_lines << "|  #{SUIT_TO_SYMBOL[suit]}  |"
      lower_rank_lines << format_rank_line(rank, 'lower')
    end
  end
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
  prompt "#{final_winner} is the first to #{final_win_condition} and " \
         "the final winner of Twenty-One!"
  sleep(2)
end

def update_score!(scoreboard, winner)
  scoreboard[winner][:score] += 1
end

def update_round!(scoreboard)
  scoreboard[:round] += 1
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
  settings = configure_settings
  play_game(settings)

  break unless play_again?
end

prompt 'goodbye'
