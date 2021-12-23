require "colorize"

instructions = []
File.open('../input/day02.txt').each { |line| instructions << line.split }

# Find how much we move and descend
horizontal_position = 0
depth = 0

instructions.each do |instruction|
  case instruction[0]
  when "forward"
    horizontal_position += instruction[1].to_i
  when "down"
    depth += instruction[1].to_i
  when "up"
    depth -= instruction[1].to_i
  end
end

puts "02.A Horizontal #{horizontal_position}, depth #{depth}, result #{(horizontal_position * depth).to_s.green}"

# Use aim to set depth
horizontal_position = 0
depth = 0
aim = 0

instructions.each do |instruction|
  case instruction[0]
  when "forward"
    horizontal_position += instruction[1].to_i
    depth += aim * instruction[1].to_i
  when "down"
    aim += instruction[1].to_i
  when "up"
    aim -= instruction[1].to_i
  end
end

puts "02.B Horizontal #{horizontal_position}, depth #{depth}, result #{(horizontal_position * depth).to_s.green}"
