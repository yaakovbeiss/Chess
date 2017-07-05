require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display

  def initialize(board = Board.new)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    system("clear")

    puts "   #{("A".."H").to_a.join("  ")} "
    @board.grid.each_with_index do |row, x|
      print "#{x} "
      row.each_with_index do |square, y|
        back_color = background_color([x,y])
        if (x.even? && y.even?) || (x.odd? && y.odd?)
          print " #{@board.grid[x][y].display} ".colorize(background: back_color)
        else
          print " #{@board.grid[x][y].display} ".colorize(background: back_color)
        end
      end
      puts ""
    end
  end

  def background_color(pos)
    if pos == @cursor.cursor_pos
     :red
    elsif (pos.all? {|x| x.even? }) || (pos.all? {|y| y.odd?})
      :grey
    else
      :white
    end
  end

  def render_move
    until false
      render
      @cursor.get_input
      system("clear")
    end
  end

end

board = Board.new
display = Display.new(board)
display.render_move