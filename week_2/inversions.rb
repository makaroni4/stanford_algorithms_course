require "test/unit"

extend Test::Unit::Assertions

def merge_and_count(left, right)
  inversions_count = 0
  output = []

  i = 0
  j = 0

  while i < left.length && j < right.length do
    if left[i] > right[j]
      output.push(right[j])
      j += 1
      inversions_count += left.length - i
    else
      output.push(left[i])
      i += 1
    end
  end

  output += left[i..-1] if i < left.length
  output += right[j..-1] if j < right.length

  [output, inversions_count]
end

assert_equal merge_and_count([1, 3, 5], [2, 4, 6]), [[1, 2, 3, 4, 5, 6], 3]
assert_equal merge_and_count([4, 5, 6], [1, 2, 3]), [[1, 2, 3, 4, 5, 6], 9]
assert_equal merge_and_count([1, 2], [3]), [[1, 2, 3], 0]
assert_equal merge_and_count([2], [1, 3]), [[1, 2, 3], 1]

def sort_and_count_inversions(array)
  return [array, 0] if array.length < 2

  left, right = array.first(array.length / 2), array.last(array.length - array.length / 2)

  sorted_left, left_inversions = sort_and_count_inversions(left)
  sorted_right, right_inversions = sort_and_count_inversions(right)
  sorted_array, split_inversions = merge_and_count(sorted_left, sorted_right)

  [sorted_array, left_inversions + right_inversions + split_inversions]
end

def count_inversions(array)
  _, inversions_count = sort_and_count_inversions(array)

  inversions_count
end

assert_equal sort_and_count_inversions([1, 3, 5, 2, 4, 6]), [[1, 2, 3, 4, 5, 6], 3]
assert_equal sort_and_count_inversions([6, 5, 4, 3, 2, 1]), [[1, 2, 3, 4, 5, 6], 15]

numbers = File.read("numbers.txt").strip.split("\n").map(&:to_i)
puts count_inversions(numbers)
