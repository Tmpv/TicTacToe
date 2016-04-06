class TicTacToeGame
  attr_accessor :player_one, :player_two, :board, :winner

  def initialize(name_one, name_two)
    @player_one = TicTacToePlayer.new(name_one, 'X')
    @player_two = TicTacToePlayer.new(name_two, 'O')
    @board = TicTacToeBoard.new
  end

  def players
    [player_one, player_two]
  end

  def tie?
    board.content.flatten.all?(&:taken?)
  end

  def won?
    @winner = if board.won_by?(player_one)
                player_one
              elsif board.won_by?(player_two)
                player_two
              else
                false
              end
  end

  def winner

  end
end

class TicTacToeBoard
  attr_accessor :content

  def initialize
    # Initial board field

    @content = [
      [TicTacToeField.new(1), TicTacToeField.new(2), TicTacToeField.new(3)],
      [TicTacToeField.new(4), TicTacToeField.new(5), TicTacToeField.new(6)],
      [TicTacToeField.new(7), TicTacToeField.new(8), TicTacToeField.new(9)],
    ]
  end

  def print
    # Sample Tic Tac Toe
    # ' --- --- ---
    #  | 1 | 2 | 3 |
    #   --- --- ---
    #  | 4 | 5 | 6 |
    #  --- --- ---
    #  | 7 | 8 | 9 |
    #   --- --- --- '

    @content.each_with_index do |row, index|
      puts " --- --- --- "
      puts "| #{row[0].to_s} | #{row[1].to_s} | #{row[2].to_s} |"
    end

    puts " --- --- --- " # Final line
  end

  def empty!
    content.flatten.each(&:empty!)
  end

  def fields_for(player)
    content.flatten.select { |x| x.player == player}
  end

  def play_on(field_position, player)
    field = content.flatten.detect { |x| x.position == field_position.to_i }
    if field.taken?
      puts "The field is taken by #{field.player.name}"
      false
    else
      puts "Player #{player.name} played on #{field.position.to_i}"
      field.player = player
    end
  end

  def won_by?(player)
    player_posiotions = fields_for(player).map(&:position).sort
    winning_positions.include? player_posiotions
  end

  def winning_positions
    [
      # Vertical winning positions

      [1,2,3],
      [4,5,6],
      [7,8,9],

      # Horizontal winning posiotions

      [1,4,7],
      [2,5,8],
      [3,6,9],
      # Cross winning posiotions

      [1,5,9],
      [3,5,7]
    ]
  end
end

class TicTacToeField
  attr_accessor :player, :position

  def initialize(position)
    @position = position
  end

  def empty!
    player = nil
  end

  def taken?
    !player.nil?
  end

  def to_s
    taken? ? player.symbol : position
  end
end

class TicTacToePlayer
  attr_accessor :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end
