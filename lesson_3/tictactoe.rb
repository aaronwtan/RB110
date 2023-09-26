require 'yaml'
MESSAGES = YAML.load_file('tictactoe.yml')

COMPUTER_PLAYERS = ['computer', 'computer 1', 'computer 2']

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

def format_header(msg)
  "----- #{msg} -----"
end

def format_footer(length)
  '-' * length
end

# player name methods
def initialize_players_and_markers
  player1 = ask_player(1)
  player2 = ask_player(2)
  update_duplicate_names!(player1, player2)

  players = [player1, player2]
  markers = { player1 => PLAYER1_MARKER, player2 => PLAYER2_MARKER }

  [players, markers]
end

def ask_player(player_number)
  case player_number
  when 1
    prompt "Is player #{player_number} (#{PLAYER1_MARKER}) a human or computer?"
  when 2
    prompt "Is player #{player_number} (#{PLAYER2_MARKER}) a human or computer?"
  end

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
      prompt "Welcome #{name}!"
      sleep(1.5)
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
  prompt 'who_goes_first_option'

  loop do
    first_player_choice = gets.chomp.downcase
    case first_player_choice
    when 'choose'   then return choose_first_player(players)
    when 'computer' then return random_first_player(players)
    else                 prompt 'invalid_first_player_choice'
    end
  end
end

def choose_first_player(players)
  prompt "Who would you like to go first (#{joinor(players)})? " \
         "Player who goes first will alternate between rounds."
  loop do
    first_player = gets.chomp
    if players.include?(first_player)
      prompt "You chose #{first_player} to go first!"
      sleep(3)
      return first_player
    end

    prompt "Invalid choice. Please choose #{joinor(players)}."
  end
end

def random_first_player(players)
  first_player = players.sample
  prompt "Computer chose #{first_player} to go first!"
  sleep(3)
  first_player
end

def display_current_player(current_player)
  prompt "It's #{current_player}'s turn."
end

# score and game board methods
def display_score_and_board(scoreboard, brd)
  system 'clear'
  display_scoreboard(scoreboard)
  puts "#{scoreboard[:player1][:name]} is #{PLAYER1_MARKER}. " \
       "#{scoreboard[:player2][:name]} is #{PLAYER2_MARKER}."
  display_board(brd)
end

def initialize_scoreboard(players)
  { round: 1,
    player1: { name: players.first, score: 0 },
    player2: { name: players.last, score: 0 } }
end

def display_scoreboard(scoreboard)
  header = format_header("ROUND #{scoreboard[:round]}")

  puts header
  puts "#{scoreboard[:player1][:name]}: #{scoreboard[:player1][:score]}"
  puts "#{scoreboard[:player2][:name]}: #{scoreboard[:player2][:score]}"
  puts format_footer(header.length)
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = EMPTY_MARKER }
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
  move = ''

  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    move = gets.chomp.to_i
    break if empty_squares(brd).include?(move)

    prompt 'invalid_player_choice'
  end

  brd[move] = player_markers[current_player]
end

def display_computer_loading(current_player)
  print "#{current_player} is choosing"
  sleep(0.3)

  3.times do
    print '.'
    sleep(0.2)
  end
end

def computer_places_piece!(brd, current_player, player_markers)
  display_computer_loading(current_player)

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

  sleep(3)
end

def display_final_result(scoreboard)
  final_winner = detect_final_winner(scoreboard)
  final_round = scoreboard[:round]

  prompt "#{final_winner} is the final winner after #{final_round} rounds!"
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
  if scoreboard[:player1][:score] >= 5
    scoreboard[:player1][:name]
  elsif scoreboard[:player2][:score] >= 5
    scoreboard[:player2][:name]
  end
end

def play_again?
  prompt 'play_again'
  loop do
    answer = gets.chomp.downcase
    return %w(y yes).include?(answer) if %w(y yes n no).include?(answer)

    prompt 'invalid_play_again'
  end
end

# start of game
prompt 'welcome'

players, player_markers = initialize_players_and_markers

# main game loop
loop do
  scoreboard = initialize_scoreboard(players)
  first_player = ask_first_player(players)

  # round loop
  loop do
    current_player = first_player
    board = initialize_board

    # player turn loop
    loop do
      display_score_and_board(scoreboard, board)
      display_current_player(current_player)
      place_piece!(board, current_player, player_markers)
      current_player = alternate_player(current_player, players)

      break if round_winner?(board) || board_full?(board)
    end

    update_score!(scoreboard, board)
    display_score_and_board(scoreboard, board)
    display_round_result(scoreboard, board)

    break if final_winner?(scoreboard)

    first_player = alternate_player(first_player, players)
    update_round!(scoreboard)
  end

  display_final_result(scoreboard)

  break unless play_again?
end

prompt 'goodbye'
