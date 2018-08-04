numbers = File.read("input.dat").strip.split("\n").map(&:to_i)

def median(array)
  sorted_array = array.sort
  l = array.length

  if l % 2 == 0
    sorted_array[l / 2 - 1]
  else
    sorted_array[(l + 1) / 2 - 1]
  end
end

median_sum = 0

numbers.length.times do |i|
  median_sum += median(numbers[0..i])
end

puts median_sum % 10_000
