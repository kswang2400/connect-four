
class Board
  def initialize(size)
    @board = Array.new(size) { Array.new(size, "[ ]") }
    @size = size
  end

  def print_board
    puts " "
    @board.each do |row|
      p row
    end
    puts " "
  end

  def set_piece(symbol, column)
    raise "no column there" if column >= @size || column < 0
    row = find_next_space(column)
    raise "full column, cannot play there" unless row
    @board[row][column] = symbol

    return [row, column]
  end

  def find_next_space(column)
    (0...@size).each do |row|
      return false if @board[row][column] != "[ ]"
      return row if row == @size - 1
      return row if @board[row + 1][column] != "[ ]"
    end
  end
end