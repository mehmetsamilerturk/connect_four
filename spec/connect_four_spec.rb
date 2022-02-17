# frozen_string_literal: true

require_relative '../lib/connect_four'

describe Game do
  subject(:game) { described_class.new }
  let(:board) { game.board }

  describe '#play_turn' do
    subject(:game_turn) { described_class.new }
    let(:player1) { Player.new }
    let(:player2) { Player.new(2) }

    context 'when 4 discs are together horizontally' do
      before do
        allow(game_turn).to receive(:gets).and_return(0, 6, 1, 5, 2, 4, 3)
        allow(game_turn).to receive(:print_board)
        allow(game_turn).to receive(:print)
      end

      it 'displays a message and stops loop' do
        message = "\nPLAYER 1 WINS!".red
        expect(game_turn).to receive(:puts).with(message)
        game_turn.play_turn(player1, player2)
      end
    end

    context 'when 4 discs are together vertically' do
      before do
        allow(game_turn).to receive(:gets).and_return(0, 1, 0, 1, 0, 1, 0)
        allow(game_turn).to receive(:print_board)
        allow(game_turn).to receive(:print)
      end

      it 'displays a message and stops loop' do
        message = "\nPLAYER 1 WINS!".red
        expect(game_turn).to receive(:puts).with(message)
        game_turn.play_turn(player1, player2)
      end
    end

    context 'when 4 discs are together diagonally(positive)' do
      before do
        allow(game_turn).to receive(:gets).and_return(0, 1, 2, 2, 1, 3, 3, 3, 3, 4, 2)
        allow(game_turn).to receive(:print_board)
        allow(game_turn).to receive(:print)
      end

      it 'displays a message and stops loop' do
        message = "\nPLAYER 1 WINS!".red
        expect(game_turn).to receive(:puts).with(message)
        game_turn.play_turn(player1, player2)
      end
    end

    context 'when 4 discs are together diagonally(negative)' do
      before do
        allow(game_turn).to receive(:gets).and_return(0, 0, 0, 1, 0, 1, 1, 6, 3, 2, 2)
        allow(game_turn).to receive(:print_board)
        allow(game_turn).to receive(:print)
      end

      it 'displays a message and stops loop' do
        message = "\nPLAYER 1 WINS!".red
        expect(game_turn).to receive(:puts).with(message)
        game_turn.play_turn(player1, player2)
      end
    end
  end

  describe '#drop_disc' do
    context 'when dropping a disc' do
      let(:player) { Player.new }

      it 'drops the disc to an available row in the specified column' do
        game.drop_disc(board, 2, 3, player)
        expect(board[2][3]).to eq(player.disc)
      end
    end
  end

  describe '#valid?' do
    context 'when making selection' do
      it 'returns true if the top column is empty' do
        expect(game.valid?(board, 4)).to eq(true)
      end

      it 'returns false if the top column is not empty' do
        board[5][5] = 2
        expect(game.valid?(board, 5)).to eq(false)
      end
    end
  end

  describe '#next_available_row' do
    context 'when there are 2 discs at the bottom' do
      it 'returns the correct row' do
        board[0][0] = 1
        board[1][0] = 2

        expect(game.next_available_row(board, 0)).to eq(2)
      end
    end
  end
end
