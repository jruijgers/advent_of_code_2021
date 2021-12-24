require "colorize"

numbers = nil
input = []
File.open('../input/day04.txt').each do |line|
  next if line.strip.empty?
  if numbers
    input << line.strip.split.map(&:to_i)
  else
    numbers = line.strip.split(",").map(&:to_i)
  end
end

class BingoBoard
  def initialize(rows)
    @rows = rows
  end

  def play(number)
    (0..4).each do |x|
      (0..4).each do |y|
        @rows[x][y] = nil if @rows[x][y] == number
      end
    end
  end

  def has_bingo?
    has_bingo = false
    (0..4).each do |i|
      row_has_bingo = true
      column_has_bingo = true
      (0..4).each do |j|
        row_has_bingo &= @rows[i][j].nil?
        column_has_bingo &= @rows[j][i].nil?
      end

      has_bingo |= (row_has_bingo || column_has_bingo)
    end
    has_bingo
  end

  def score(number)
    sum = 0
    (0..4).each do |i|
      (0..4).each do |j|
        sum += @rows[i][j] unless @rows[i][j].nil?
      end
    end

    sum * number
  end

  def to_s
    @rows.map { |v| v.join(",") }
  end
end

boards = []
boards << BingoBoard.new(input.slice!(0, 5)) while input.length > 0

first_bingo = nil
last_bingo = nil
first_bingo_number = 0
last_bingo_number = 0
while numbers.length > 0
  number = numbers.slice!(0)

  boards.each do |board|
    next if board.has_bingo?

    board.play(number)

    next unless board.has_bingo?

    if first_bingo.nil?
      first_bingo = board
      first_bingo_number = number
    end
    last_bingo = board
    last_bingo_number = number
  end
end

puts first_bingo
puts last_bingo
puts "04.A The first winning board has score #{first_bingo.score(first_bingo_number).to_s.green} points"
puts "04.B The last winning board has score #{last_bingo.score(last_bingo_number).to_s.green} points"
