require "set"
require "byebug"

input = File.read("input_2.dat").strip.split("\n")[1..-1].map { |r| r.split(" ").map(&:to_i) }

vertices = {}

input.each do |v1, v2, cost|
  vertices[v1] ||= []
  vertices[v1].push([v2, cost])

  vertices[v2] ||= []
  vertices[v2].push([v1, cost])
end

mst_vertices = Set.new([vertices.keys.sample])
mst_edges = []

while mst_vertices.size < vertices.size do
  unprocessed_vertices = mst_vertices.each.inject([]) do |unprocessed_vertices, v|
    unprocessed_vertices += vertices[v].select do |vv, cost|
      !mst_vertices.member?(vv)
    end.map { |vv, cost| [v, vv, cost] }
  end

  next_edge = unprocessed_vertices.min_by do |v|
    v.last
  end

  v, vv, cost = next_edge

  mst_vertices.add(vv)
  mst_edges.push([v, vv, cost])
end

mst_cost = mst_edges.map(&:last).reduce(:+)

puts mst_cost
