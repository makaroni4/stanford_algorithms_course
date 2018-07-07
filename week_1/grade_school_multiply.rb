require "test/unit"

extend Test::Unit::Assertions

def grade_school_multiply(x, y)
  y = y.split("").map(&:to_i)
  x = x.split("").map(&:to_i)

  result = []
  x.reverse.each_with_index do |x_digit, i|
    y.reverse.each_with_index do |y_digit, j|
      product = x_digit * y_digit

      result[j + i] ||= 0
      result[j + i] += product

      if result[j + i] > 9
        propagate = true
        k = 0

        while propagate do
          i_j_k = result[j + i + k]
          result[j + i + k] = i_j_k % 10

          result[j + i + k + 1] ||= 0
          result[j + i + k + 1] += i_j_k / 10

          propagate = false if result[j + i + k + 1] < 10

          k += 1
        end
      end
    end
  end

  result.reverse.join("")
end

assert_equal grade_school_multiply("2", "2"), "4"
assert_equal grade_school_multiply("36", "49"), "1764"
assert_equal grade_school_multiply("1293812", "23408237412"), "30285858462494544"
assert_equal grade_school_multiply("23408237412", "12983"), "303909146319996"

puts grade_school_multiply(
  "3141592653589793238462643383279502884197169399375105820974944592",
  "2718281828459045235360287471352662497757247093699959574966967627"
)
