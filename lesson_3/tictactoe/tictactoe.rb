require 'yaml'
require 'pry'

MESSAGES = YAML.load_file('tictactoe.yml')
PRELOADING_MESSAGE_KEYS = Array.new(9) { |i| "loading#{i}" }

DEFAULT_SETTINGS = { players: ['Player', 'Computer'],
                     first_player: :player1,
                     final_win_condition: 5,
                     first_game: false }

COMPUTER_PLAYERS = ['computer', 'computer 1', 'computer 2']

RULES = <<-MSG
---------- RULES ----------
=> Players take turns putting their markers in empty squares. The
=> first player to get 3 of their markers in a row (horizontally,
=> vertically, or diagonally) is the winner. When all 9 squares
=> are full, the game is over. If no player has 3 markers in a row,
=> the game ends in a tie.

=> Markers can be placed on the gameboard by typing a number 1-9
=> corresponding to the appropriate square, as shown below.
=> (Type 'h' or 'help' during gameplay to show these rules again.)
MSG

EMPTY_MARKER = ' '
PLAYER1_MARKER = 'X'
PLAYER2_MARKER = 'O'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals

# formatting methods
def prompt(msg)
  if MESSAGES.key?(msg)
    puts "=> #{MESSAGES[msg]}"
  else
    puts "=> #{msg}"
  end
end

def joinor(arr, delimiter=', ', word='or')
  case arr.size
  when 0 then ''
  when 1 then arr.first.to_s
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

def display_welcome
  title = 'Welcome to TIC-TAC-TOE!'
  display_title(title)
  sleep(2)
  display_preloading_sequence
end

def display_title(title="TIC-TAC-TOE")
  system 'clear'
  top_bottom_edge = '-' * (title.length + 2)

  puts "+#{top_bottom_edge}+"
  puts "| #{title} |"
  puts "+#{top_bottom_edge}+"
  puts ''
end

def display_preloading_sequence
  title = 'Welcome to TIC-TAC-TOE!'

  1.upto(5) do |num|
    system 'clear'
    display_title(title)

    display_loading_bar(num, title.length + 4)

    case num
    when 1..4
      display_computer_loading(MESSAGES[PRELOADING_MESSAGE_KEYS.sample], 0.4)
    when 5
      # slow down before loading completion for dramatic effect
      display_computer_loading(MESSAGES['get_ready'], 1)
    end
  end
end

def display_loading_bar(section, total_length)
  num_of_load_segments = section * 5
  total_load_segments = total_length - 2
  print "[#{'-' * num_of_load_segments}" \
        "#{' ' * (total_load_segments - num_of_load_segments)}] "
  puts "#{num_of_load_segments / total_load_segments.to_f * 100}% Loading..."
end

def display_computer_loading(msg, loading_time)
  print msg
  sleep(0.3)

  3.times do
    print '.'
    sleep(loading_time)
  end

  puts ''
end

def format_header(msg)
  "----- #{msg} -----"
end

def format_footer(length)
  '-' * length
end

# game and settings methods
def play_game(settings=DEFAULT_SETTINGS)
  first_player = settings[:first_player]
  scoreboard = initialize_scoreboard(settings[:players],
                                     settings[:final_win_condition])
  ask_player_ready

  # round loop
  loop do
    play_round(first_player, scoreboard)

    break if final_winner?(scoreboard)

    first_player = alternate_player(first_player)
    update_round!(scoreboard)
  end

  display_final_result(scoreboard)
end

def initialize_settings
  settings = DEFAULT_SETTINGS
  settings[:first_game] = true
  settings
end

def ask_settings(settings)
  system 'clear'
  if settings[:first_game]
    settings[:first_game] = false
    ask_default_settings
  else
    prompt 'ask_change_settings'
    if answered_yes?
      ask_default_settings
    else
      prompt 'same_settings'
      sleep(2)
      settings
    end
  end
end

def ask_default_settings
  system 'clear'
  prompt 'ask_default_settings'
  if answered_yes?
    prompt 'default_game'
    sleep(3)
    ask_rules
    configure_settings(default: true)
  else
    prompt 'configure_settings'
    sleep(3)
    configure_settings
  end
end

def configure_settings(default: false)
  return DEFAULT_SETTINGS if default

  players = initialize_players
  first_player = ask_first_player(players)
  final_win_condition = ask_final_win_condition
  ask_rules

  { players: players,
    first_player: first_player,
    final_win_condition: final_win_condition,
    first_game: false }
end

def initialize_players
  player1 = ask_player(1)
  display_greeting(player1, 1)
  player2 = ask_player(2)
  display_greeting(player2, 2)
  update_duplicate_names!(player1, player2)

  [player1, player2]
end

def display_greeting(player, player_number)
  if player.downcase == 'computer'
    prompt "The computer will play as Player #{player_number}."
  else
    prompt "Welcome #{player}! You will play as Player #{player_number}."
  end
  sleep(2)
end

def ask_player(player_number)
  system 'clear'
  case player_number
  when 1
    prompt "Player #{player_number} will play as #{PLAYER1_MARKER}."
  when 2
    prompt "Player #{player_number} will play as #{PLAYER2_MARKER}."
  end

  prompt "Is player #{player_number} a human or computer? (h/c)"
  human? ? ask_name : 'Computer'
end

def human?
  loop do
    answer = gets.chomp.downcase
    if %w(h c human computer).include?(answer)
      return %w(h human).include?(answer)
    end

    prompt 'invalid_human_or_computer'
  end
end

def ask_name
  loop do
    prompt 'ask_human_name'
    name = gets.chomp

    if name.strip.empty?
      prompt 'invalid_name'
    elsif name.downcase == 'computer'
      prompt 'computer_name'
    else
      return name
    end
  end
end

def update_duplicate_names!(player1, player2)
  if player1 == player2
    player1 << ' 1'
    player2 << ' 2'
  end
end

def ask_first_player(players)
  system 'clear'
  prompt "Who would you like to go first (#{joinor(players)})? " \
         "(Press enter to let the computer decide.)"

  loop do
    choice = gets.chomp
    first_player = determine_first_player(choice, players)

    return first_player unless first_player.nil?

    prompt "Invalid choice. Please choose #{joinor(players)}. " \
           "Press enter to let the computer decide."
  end
end

def determine_first_player(first_player_choice, players)
  if players.include?(first_player_choice)
    first_player = first_player_choice
    prompt "You chose #{first_player} to go first! " \
           "Player who goes first will alternate between rounds."
    sleep(3)
  elsif first_player_choice.empty?
    first_player = players.sample
    prompt "Computer chose #{first_player} to go first! " \
           "Player who goes first will alternate between rounds."
    sleep(3)
  end

  case first_player
  when players.first then :player1
  when players.last  then :player2
  end
end

def display_rules
  system 'clear'
  puts RULES
  reference_board = initialize_board(show_references: true)
  display_board(reference_board)
end

def ask_rules
  system 'clear'
  prompt 'ask_rules'

  if answered_yes?
    display_rules
  else
    prompt 'no_rules'
  end
end

def toggle_help!(brd)
  brd[:help] = !brd[:help]
end

def ask_player_ready
  prompt 'ready'
  gets
end

def display_current_player(current_player, scoreboard)
  prompt "It's #{scoreboard[current_player][:name]}'s turn."
end

# round methods
def play_round(first_player, scoreboard)
  current_player = first_player
  board = initialize_board

  # player turn loop
  loop do
    play_turn(board, current_player, scoreboard)

    break if round_winner?(board) || board_full?(board)

    current_player = alternate_player(current_player) unless board[:help]
  end

  update_score!(scoreboard, board)
  display_game(scoreboard, board)
  display_round_result(scoreboard, board)
end

def display_game(scoreboard, brd)
  system 'clear'
  display_title

  display_scoreboard(scoreboard)
  puts "#{scoreboard[:player1][:name]} is #{PLAYER1_MARKER}. " \
       "#{scoreboard[:player2][:name]} is #{PLAYER2_MARKER}."
  puts "First to #{scoreboard[:final_win_condition]} wins!"

  display_board(brd)
end

def initialize_scoreboard(players, final_win_condition)
  { player1: { name: players.first, marker: PLAYER1_MARKER, score: 0 },
    player2: { name: players.last, marker: PLAYER2_MARKER, score: 0 },
    round: 1,
    final_win_condition: final_win_condition }
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

def display_scoreboard(scoreboard)
  header = format_header("ROUND #{scoreboard[:round]}")

  puts header
  puts "#{scoreboard[:player1][:name]}: #{scoreboard[:player1][:score]}"
  puts "#{scoreboard[:player2][:name]}: #{scoreboard[:player2][:score]}"
  puts format_footer(header.length)
end

def initialize_board(show_references: false)
  new_board = {}
  if show_references
    (1..9).each { |num| new_board[num] = num }
  else
    (1..9).each { |num| new_board[num] = EMPTY_MARKER }
    new_board[:help] = false
  end
  new_board
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def alternate_player(current_player)
  current_player == :player1 ? :player2 : :player1
end

def update_round!(scoreboard)
  scoreboard[:round] += 1
end

def update_score!(scoreboard, brd)
  scoreboard[detect_winner(brd)][:score] += 1 if round_winner?(brd)
end

# player turn methods
def play_turn(brd, current_player, scoreboard)
  display_help(brd) if brd[:help]

  display_game(scoreboard, brd)
  display_current_player(current_player, scoreboard)
  place_piece!(brd, current_player, scoreboard)
end

def display_help(brd)
  toggle_help!(brd)
  display_rules
  ask_player_ready
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == EMPTY_MARKER }
end

def place_piece!(brd, current_player, scoreboard)
  if COMPUTER_PLAYERS.include?(scoreboard[current_player][:name].downcase)
    computer_places_piece!(brd, current_player, scoreboard)
  else
    player_places_piece!(brd, current_player, scoreboard)
  end
end

def player_places_piece!(brd, current_player, scoreboard)
  move = ask_player_move(brd)

  if move == 'help'
    toggle_help!(brd)
  else
    brd[move] = scoreboard[current_player][:marker]
  end
end

def ask_player_move(brd)
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}) " \
           "or type 'help' for help:"
    move = gets.chomp.downcase

    if %w(h help).include?(move)
      return 'help'
    elsif valid_number_string?(move) && empty_squares(brd).include?(move.to_i)
      return move.to_i
    end

    prompt 'invalid_player_choice'
  end
end

def computer_places_piece!(brd, current_player, scoreboard)
  display_computer_loading("#{scoreboard[current_player][:name]} " \
                           "is choosing", 0.2)

  # prioritize offensive winning move when possible
  move = find_move(brd, current_player, scoreboard)

  # defense if no offensive move available
  move = find_move(brd, alternate_player(current_player), scoreboard) if !move

  # if no offensive or defensive moves and square #5 empty, pick square #5
  move = 5 if !move && brd[5] == EMPTY_MARKER

  # otherwise pick random square if no preceding move available
  move = empty_squares(brd).sample if !move

  brd[move] = scoreboard[current_player][:marker]
end

def find_move(brd, at_risk_player, scoreboard)
  WINNING_LINES.each do |line|
    move = find_at_risk_square(line, brd, scoreboard[at_risk_player][:marker])
    return move unless move.nil?
  end
  nil
end

def find_at_risk_square(line, brd, marker)
  if line.count { |square| brd[square] == marker } == 2
    line.select { |square| brd[square] == EMPTY_MARKER }.first
  end
end

# result methods
def display_round_result(scoreboard, brd)
  round_winner = scoreboard[detect_winner(brd)][:name] if round_winner?(brd)

  if round_winner.nil?
    prompt 'tie'
  else
    prompt "#{round_winner} won!"
  end

  sleep(2)
end

def display_final_result(scoreboard)
  final_winner = detect_final_winner(scoreboard)
  final_win_condition = scoreboard[:final_win_condition]
  final_round = scoreboard[:round]
  final_game_str = 'game'
  final_round_str = 'round'

  pluralize_string!(final_game_str) if final_win_condition > 1
  pluralize_string!(final_round_str) if final_round > 1

  prompt "#{final_winner} won #{final_win_condition} #{final_game_str} " \
         "and is the final winner after #{final_round} #{final_round_str}!"
end

def pluralize_string!(string)
  string << 's'
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def round_winner?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if line.all? { |square| brd[square] == PLAYER1_MARKER }
      return :player1
    elsif line.all? { |square| brd[square] == PLAYER2_MARKER }
      return :player2
    end
  end
  nil
end

def final_winner?(scoreboard)
  !!detect_final_winner(scoreboard)
end

def detect_final_winner(scoreboard)
  if scoreboard[:player1][:score] >= scoreboard[:final_win_condition]
    scoreboard[:player1][:name]
  elsif scoreboard[:player2][:score] >= scoreboard[:final_win_condition]
    scoreboard[:player2][:name]
  end
end

def play_again?
  prompt 'play_again'
  answered_yes?
end

def answered_yes?
  loop do
    answer = gets.chomp.downcase
    return %w(y yes).include?(answer) if %w(y yes n no).include?(answer)

    prompt 'invalid_yes_or_no'
  end
end

# ------------------------------------------------------------

# start of game
display_welcome
settings = initialize_settings

# main game loop
loop do
  settings = ask_settings(settings)
  play_game(settings)

  break unless play_again?
end

prompt 'goodbye'
