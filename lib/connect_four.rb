# frozen_string_literal: true

require_relative 'color'

class Game
  attr_accessor :board, :game_over

  def initialize
    @board = initialize_board(6, 0)
    @column = nil
    @row_size = 6
    @column_size = 7
  end

  def play_game(player1 = nil, player2 = nil)
    player1 = Player.new if player1.nil?
    player2 = Player.new(2) if player2.nil?

    play_turn(player1, player2)
  end

  def play_turn(player1, player2)
    turn = 0
    loop do
      print_board

      if turn.zero?
        print "#{'Player 1'.red}'s turn: "
        @column = gets
        @column = @column.to_i

        if valid?(@board, @column)
          row = next_available_row(@board, @column)
          drop_disc(@board, row, @column, player1)

          if decide_winner(@board, player1)
            print_board
            puts "\nPLAYER 1 WINS!".red
            return
          end
        end

      else
        print "#{'Player 2'.yellow}'s turn: "
        @column = gets.to_i

        if valid?(@board, @column)
          row = next_available_row(@board, @column)
          drop_disc(@board, row, @column, player2)

          if decide_winner(@board, player1)
            print_board
            puts "\nPLAYER 2 WINS!".red
            return
          end
        end
      end

      if draw(@board)
        puts 'DRAW!'
        return
      end

      turn += 1
      turn = turn % 2
    end
  end

  def decide_winner(board, player)
    result = false
    # horizontal
    (@column_size - 3).times do |c|
      @row_size.times do |r|
        if board[r][c] == player.disc && board[r][c + 1] == player.disc && board[r][c + 2] == player.disc && board[r][c + 3] == player.disc
          result = true
        end
      end
    end

    # vertical
    @column_size.times do |c|
      (@row_size - 3).times do |r|
        if board[r][c] == player.disc && board[r + 1][c] == player.disc && board[r + 2][c] == player.disc && board[r + 3][c] == player.disc
          result = true
        end
      end
    end

    # positive diagonal
    (@column_size - 3).times do |c|
      (@row_size - 3).times do |r|
        if board[r][c] == player.disc && board[r + 1][c + 1] == player.disc && board[r + 2][c + 2] == player.disc && board[r + 3][c + 3] == player.disc
          result = true
        end
      end
    end

    # negative diagonal
    (@column_size - 3).times do |c|
      (3..(@row_size - 1)).each do |r|
        if board[r][c] == player.disc && board[r - 1][c + 1] == player.disc && board[r - 2][c + 2] == player.disc && board[r - 3][c + 3] == player.disc
          result = true
        end
      end
    end

    result
  end

  def draw(board)
    board.flatten.all? { |cell| cell.between?(1, 2) }
  end

  def drop_disc(board, row, column, player)
    board[row][column] = player.disc
  end

  def valid?(board, column)
    (board[5][column]).zero?
  end

  def next_available_row(board, column)
    @row_size.times do |i|
      return i if (board[i][column]).zero?
    end
  end

  def print_board
    @board.reverse.each { |row| p row }
  end

  private

  def initialize_board(n, val)
    board = Array.new(n)
    n.times do |row_index|
      board[row_index] = Array.new(n)
      7.times do |column_index|
        board[row_index][column_index] = val
      end
    end
    board
  end
end

class Player
  attr_accessor :disc

  def initialize(disc = 1)
    @disc = disc
  end
end

 game = Game.new
 game.play_game
# p game.board[2][3]
