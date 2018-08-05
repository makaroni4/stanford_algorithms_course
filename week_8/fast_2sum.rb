numbers = File.read("input.dat").strip.split("\n").map(&:to_i).sort

two_sum = {}

numbers.each do |n|
  low_n = -10_000 - n
  high_n = 10_000 - n

  low_i = numbers.bsearch_index { |k| k >= low_n }
  high_i = numbers.bsearch_index { |k| k > high_n }

  next if low_i.nil? || high_i.nil?

  numbers[low_i..(high_i - 1)].each do |m|
    next if n == m

    two_sum[n + m] ||= 0
    two_sum[n + m] += 1
  end
end

puts two_sum.size
