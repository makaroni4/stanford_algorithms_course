require "test/unit"
require "byebug"

extend Test::Unit::Assertions

@comparisons = 0

def median_of_three_pivot(array, l, r)
  m = r - l + 1
  k = l + (m % 2 == 0 ? m / 2 - 1 : m / 2)

  [l, k, r].sort_by { |i| array[i] }[1]
end

assert_equal median_of_three_pivot([1, 2 ,3], 0, 2), 1
assert_equal median_of_three_pivot([8, 2, 4, 5, 7, 1], 0, 5), 2
assert_equal median_of_three_pivot([4, 5, 6, 7], 0, 3), 1

def quick_sort(array, l, r)
  return if l >= r

  @comparisons += r - l

  # 1. Choosing pivot as 1st element
  pivot = l

  # 2. Choosing pivot as last element
  # pivot = r

  # 3. Choosing "median-of-three" pivot
  # pivot = median_of_three_pivot(array, l, r)

  array[pivot], array[l] = array[l], array[pivot]

  pivot = l

  i = l + 1
  j = l + 1

  while j <= r do
    if array[j] < array[pivot]
      array[i], array[j] = array[j], array[i]
      i += 1
    end

    j += 1
  end

  array[pivot], array[i - 1] = array[i - 1], array[pivot]

  quick_sort(array, l, i - 2)
  quick_sort(array, i, r)
end

20.times do
  a = (1..25).to_a.shuffle
  quick_sort(a, 0, a.length - 1)
  assert_equal a, (1..25).to_a
end

@comparisons = 0
numbers = File.read("input.dat").strip.split("\n").map(&:to_i)
quick_sort(numbers, 0, numbers.length - 1)
puts @comparisons
