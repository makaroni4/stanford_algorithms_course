numbers = File.read("input_1.dat").strip.split("\n")[1..-1].map { |r| r.split(" ").map(&:to_i) }

difference_comparison = -> (a, b) {
  a_val = a[0] - a[1]
  b_val = b[0] - b[1]

  if b_val > a_val || (a_val == b_val && b[0] > a[0])
    +1
  elsif b_val < a_val || (a_val == b_val && b[0] < a[0])
    -1
  else
    0
  end
}

ratio_comparison = -> (a, b) {
  a_val = a[0].to_f / a[1]
  b_val = b[0].to_f / b[1]

  if b_val > a_val
    +1
  elsif b_val < a_val
    -1
  else
    0
  end
}

def calculate_weighted_sum(numbers, comparison)
  current_length = 0
  weighted_sum = 0

  numbers.sort(&comparison).each do |weight, length|
    current_length += length
    weighted_sum += weight * current_length
  end

  weighted_sum
end

puts calculate_weighted_sum(numbers, difference_comparison)
puts calculate_weighted_sum(numbers, ratio_comparison)
