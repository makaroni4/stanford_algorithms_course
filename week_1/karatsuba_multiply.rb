require "test/unit"

extend Test::Unit::Assertions

def karatsuba_multiply(ab, cd)
  return ab * cd if ab < 10 || cd < 10

  l = [ab.to_s.length, cd.to_s.length].max
  l2 = l / 2

  a, b = ab / (10 ** l2), ab % (10 ** l2)
  c, d = cd / (10 ** l2), cd % (10 ** l2)

  n1 = karatsuba_multiply(a, c)
  n2 = karatsuba_multiply(b, d)
  n3 = karatsuba_multiply((a + b), (c + d))


  n1 * (10 ** (l2 * 2)) + (n3 - n2 - n1) * (10 ** l2) + n2
end

assert_equal karatsuba_multiply(2, 2), 4
assert_equal karatsuba_multiply(36, 49), 1764
assert_equal karatsuba_multiply(1293812, 23408237412), 30285858462494544
assert_equal karatsuba_multiply(23408237412, 12983), 303909146319996

puts karatsuba_multiply(
  3141592653589793238462643383279502884197169399375105820974944592,
  2718281828459045235360287471352662497757247093699959574966967627
)
