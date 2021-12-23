require "colorize"

input = []
File.open('../input/day03.txt').each { |line| input << line.strip }

def get_counts(input)
  counts = []
  (0..(input.first.length - 1)).each { |i| counts[i] = 0 }
  input.each do |reading|
    chars = reading.split('')
    (0..(chars.length - 1)).each { |i| counts[i] += 1 if chars[i] == "1" }
  end
  counts
end

counts = get_counts(input)
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

def find_rating(input, value_to_select)
  (0..(input.first.length - 1)).each do |i|
    next if input.size == 1

    counts = get_counts(input)

    if counts[i] >= input.length / 2.0
      input = input.select { |v| v[i] == value_to_select }
    else
      input = input.select { |v| v[i] != value_to_select }
    end
  end

  input.first
end

def binary_to_decimal(value)
  result = 0
  i = value.length - 1
  value.split("").each do |char|
    result += 2 ** i if char == "1"
    i -= 1
  end

  result
end

oxygen_generator_rating = binary_to_decimal(find_rating(input.dup, "1"))
co2_scrubber_rating = binary_to_decimal(find_rating(input.dup, "0"))
puts "oxygen generator rating #{oxygen_generator_rating}, CO2 scrubber rating #{co2_scrubber_rating}, result #{(oxygen_generator_rating * co2_scrubber_rating).to_s.green}"