
class Player
  attr_reader :name, :symbol

  def initialize(name, symbol, size, win_count)
    @name = name
    @pieces = []
    @horizontal = Hash.new { |h, k| h[k] = Array.new }    
    @vertical = Hash.new { |h, k| h[k] = Array.new }
    @size = size
    @symbol = symbol
    @win_count = win_count
  end

  def adjacent_spaces(space)
    [
      [space[0] + 1, space[1] + 1],
      [space[0] + 1, space[1] - 1],
      [space[0] - 1, space[1] + 1],
      [space[0] - 1, space[1] - 1]
    ]

    # shit this allow bent diagonals :(
  end

  def build_path(path, output = [])
    adjacent_spaces(path.last).each do |space|
      if @pieces.include?(space) && !path.include?(space)   # this is the check that's breaking
        new_path = path + [space]
        output += new_path
        build_path(new_path, output)
      end
    end

    output
  end

  def check_win
    check_horizontal || check_vertical || check_diagonal
  end

  def check_horizontal
    # KW: this could be refactored
    @horizontal.each do |row, column|
      next if column.count < @win_count
      check = four_in_a_row(column)
      return check if check
    end

    false
  end

  def check_vertical
    @vertical.each do |column, row|
      next if row.count < @win_count
      check = four_in_a_row(row)
      return check if check
    end

    false
  end

  def check_diagonal(count = 0)
    # needs a lot of refactoring, perhaps a cache so I dont need to rebuild every depth first search every round
    possible_paths = []
    @pieces.each { |piece| possible_paths << build_path([piece]) }

    possible_paths.each do |path|
      # very hacky, but build path check was not working, wanted to submit a working game first
      return true if path.uniq.length == @win_count
    end
    
    false
  end

  def remember_piece(row, column)
    @pieces << [row, column]
    @horizontal[row] << column
    @vertical[column] << row

    nil
  end

  def four_in_a_row(array)
    count = 0
    (0...@size).each do |n|
      if array.include?(n)  # KW: opportunity to optimize, array.include?() O(n)
        count += 1
        return true if count == @win_count
      else
        count = 0
      end
    end

    return false
  end
end