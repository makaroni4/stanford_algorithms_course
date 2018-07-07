require "benchmark/ips"
require_relative "grade_school_multiply"
require_relative "karatsuba_multiply"

Benchmark.ips do |x|
  x.config(time: 5, warmup: 2)

  N1 = 3141592653589793238462643383279502884197169399375105820974944592
  N2 = 2718281828459045235360287471352662497757247093699959574966967627

  x.report("grade_school_multiply") do
    grade_school_multiply(N1.to_s, N2.to_s)
  end

  x.report("karatsuba_multiply") do
    karatsuba_multiply(N1, N2)
  end

  x.report("*") do
    N1 * N2
  end

  x.compare!
end
