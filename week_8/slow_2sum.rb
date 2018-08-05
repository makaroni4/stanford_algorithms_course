numbers = File.read("input.dat").strip.split("\n").map(&:to_i)
numbers_counts = numbers.inject({}) do |h, n|
  h[n] ||= 0
  h[n] += 1
  h
end

puts numbers_counts.size

two_sums = 0

-10000.upto(10000) do |i|
  numbers_counts.each do |n, count|
    next if i - n == n

    if numbers_counts.has_key?(i - n)
      two_sums += 1
    end
  end

  puts i
end

puts two_sums
