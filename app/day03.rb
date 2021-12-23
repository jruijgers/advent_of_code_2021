require "colorize"

input = []
File.open('../input/day03.txt').each { |line| input << line.strip }

puts input
counts = []
(0..(input.first.length - 1)).each { |i| counts[i] = 0 }

input.each do |reading|
  chars = reading.split('')
  (0..(chars.length - 1)).each { |i| counts[i] += 1 if chars[i] == "1" }
end

gamma_rate = 0
epsilon_rate = 0

(0..(counts.length - 1)).each do |i|
  if counts[i] > input.size / 2
    gamma_rate += 2 ** (counts.length - i - 1)
  elsif counts[i] < input.size / 2
    epsilon_rate += 2 ** (counts.length - i - 1)
  end
end

puts "03.A gamma rate #{gamma_rate}, epsilon_rate #{epsilon_rate}, result #{(gamma_rate * epsilon_rate).to_s.green}"