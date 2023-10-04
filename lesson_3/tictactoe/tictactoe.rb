require 'yaml'

MESSAGES = YAML.load_file('tictactoe.yml')
PRELOADING_MESSAGES = %w(loading1 loading2 loading3 loading4 loading5
                         loading6 loading7 loading8 loading9)

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
      display_computer_loading(MESSAGES[PRELOADING_MESSAGES.sample], 0.4)
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

# player name methods
def initialize_players_and_markers
  player1 = ask_player(1)
  display_greeting(player1, 1)
  player2 = ask_player(2)
  display_greeting(player2, 2)
  update_duplicate_names!(player1, player2)

  players = [player1, player2]
  markers = { player1 => PLAYER1_MARKER, player2 => PLAYER2_MARKER }

  [players, markers]
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

  prompt "Is player #{player_number} a human or computer?"
  human? ? ask_name : 'Computer'
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

def human?
  loop do
    answer = gets.chomp.downcase
    return answer == 'human' if ['human', 'computer'].include?(answer)

    prompt 'invalid_human_or_computer'
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
    player = gets.chomp
    first_player = determine_first_player(player, players)

    return first_player unless first_player.empty?

    prompt "Invalid choice. Please choose #{joinor(players)}. " \
           "Press enter to let the computer decide."
  end
end

def determine_first_player(first_player_choice, players)
  first_player = ''

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

  first_player
end

def display_rules(rules='y')
  system 'clear'
  if %w(y yes).include?(rules)
    puts RULES
    reference_board = initialize_board(show_references: true)
    display_board(reference_board)
  else
    prompt 'no_rules'
  end
end

def ask_rules
  system 'clear'
  prompt 'ask_rules'

  loop do
    answer = gets.chomp.downcase
    if %w(y yes n no).include?(answer)
      display_rules(answer)
      break
    end

    prompt 'invalid_yes_or_no'
  end
end

def toggle_help!(brd)
  brd[:help] = !brd[:help]
end

def ask_player_ready
  prompt 'ready'
  gets
end

def display_current_player(current_player)
  prompt "It's #{current_player}'s turn."
end

# score and game board methods
def display_game(scoreboard, brd)
  system 'clear'
  display_title

  display_scoreboard(scoreboard)
  puts "#{scoreboard[:player1][:name]} is #{PLAYER1_MARKER}. " \
       "#{scoreboard[:player2][:name]} is #{PLAYER2_MARKER}."
  puts "First to #{scoreboard[:final_win_condition]} wins!"

  display_board(brd)
end

def initialize_scoreboard(players)
  { round: 1,
    player1: { name: players.first, score: 0 },
    player2: { name: players.last, score: 0 },
    final_win_condition: ask_final_win_condition }
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
    elsif valid_positive_number?(final_win_condition)
      prompt "The first player to #{final_win_condition} will win the game."
      sleep(2)
      return final_win_condition.to_i
    end

    prompt 'invalid_number'
  end
end

def valid_positive_number?(number_str)
  number_str =~ /^\d+$/ && number_str.to_i.positive?
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

def update_round!(scoreboard)
  scoreboard[:round] += 1
end

def update_score!(scoreboard, brd)
  scoreboard[detect_winner(brd)][:score] += 1 if round_winner?(brd)
end

# turn gameplay methods
def alternate_player(current_player, players)
  current_player == players.first ? players.last : players.first
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == EMPTY_MARKER }
end

def place_piece!(brd, current_player, player_markers)
  if COMPUTER_PLAYERS.include?(current_player.downcase)
    computer_places_piece!(brd, current_player, player_markers)
  else
    player_places_piece!(brd, current_player, player_markers)
  end
end

def player_places_piece!(brd, current_player, player_markers)
  move = ask_player_move(brd)

  if %w(h help).include?(move)
    toggle_help!(brd)
  else
    brd[move.to_i] = player_markers[current_player]
  end
end

def ask_player_move(brd)
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}) " \
           "or type 'help' for help:"
    move = gets.chomp.downcase
    return move if empty_squares(brd).include?(move.to_i) ||
                   %w(h help).include?(move)

    prompt 'invalid_player_choice'
  end
end

def computer_places_piece!(brd, current_player, player_markers)
  display_computer_loading("#{current_player} is choosing", 0.2)

  # prioritize offensive winning move when possible
  move = find_offensive_move(brd)

  # defense if no offensive move available
  move = find_defensive_move(brd) if !move

  # if no offensive or defensive moves and square #5 empty, pick square #5
  move = 5 if !move && brd[5] == EMPTY_MARKER

  # otherwise pick random square if no preceding move available
  move = empty_squares(brd).sample if !move

  brd[move] = player_markers[current_player]
end

def find_offensive_move(brd)
  WINNING_LINES.each do |line|
    move = find_at_risk_square(line, brd, PLAYER2_MARKER)
    return move unless move.nil?
  end
  nil
end

def find_defensive_move(brd)
  WINNING_LINES.each do |line|
    move = find_at_risk_square(line, brd, PLAYER1_MARKER)
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

  pluralize_string(final_game_str) if final_win_condition > 1
  pluralize_string(final_round_str) if final_round > 1

  prompt "#{final_winner} won #{final_win_condition} #{final_game_str} " \
         "and is the final winner after #{final_round} #{final_round_str}!"
end

def pluralize_string(string)
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
  loop do
    answer = gets.chomp.downcase
    return %w(y yes).include?(answer) if %w(y yes n no).include?(answer)

    prompt 'invalid_yes_or_no'
  end
end

# ------------------------------------------------------------

# start of game
display_welcome
display_preloading_sequence

# main game loop
loop do
  players, player_markers = initialize_players_and_markers
  scoreboard = initialize_scoreboard(players)
  first_player = ask_first_player(players)
  ask_rules
  ask_player_ready

  # round loop
  loop do
    current_player = first_player
    board = initialize_board

    # player turn loop
    loop do
      display_game(scoreboard, board)
      display_current_player(current_player)
      place_piece!(board, current_player, player_markers)

      if board[:help]
        display_rules
        ask_player_ready
        toggle_help!(board)
        next
      end

      break if round_winner?(board) || board_full?(board)

      current_player = alternate_player(current_player, players)
    end

    update_score!(scoreboard, board)
    display_game(scoreboard, board)
    display_round_result(scoreboard, board)

    break if final_winner?(scoreboard)

    first_player = alternate_player(first_player, players)
    update_round!(scoreboard)
  end

  display_final_result(scoreboard)

  break unless play_again?
end

prompt 'goodbye'
