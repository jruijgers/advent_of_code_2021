require "colorize"

depths = Array.new
File.open('../input/day01.txt').each { |line| depths << line.to_i }

# 1.A Find amount of increases
number_of_increases = 0
last_depth = depths.first

for i in 1..(depths.length-1)
  number_of_increases += 1 if depths[i] > last_depth

  last_depth = depths[i]
end

puts "01.A There are #{number_of_increases.to_s.green} increases"

# Find number of increases in a sliding window of 3 depths
def get_window(start, depths)
  stop = start + 3
  window = 0

  while start < stop
    window += depths[start]
    start += 1
  end

  window
end

number_of_increases = 0
last_window = get_window(0, depths)

for i in 1..(depths.length - 3)
  window = get_window(i, depths)

  number_of_increases += 1 if window > last_window
  last_window = window
end

puts "01.B There are #{number_of_increases.to_s.green} increases"
