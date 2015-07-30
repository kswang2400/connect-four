
require "./lib/board.rb"

describe "Board" do
  before :each do
    @board = Board.new(6)
  end

  describe "#set_piece" do 
    it "should raise an error if the input is not in range" do
      expect{ @board.set_piece(" X ", 11) }.to raise_error(RuntimeError, "no column there")
    end

    it "should raise an error if the column is full" do
      6.times { @board.set_piece(" X ", 0) }
      expect{ @board.set_piece(" X ", 0) }.to raise_error(RuntimeError, "full column, cannot play there")
    end
  end
end