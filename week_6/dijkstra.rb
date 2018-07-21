require "set"
require "pp"
require "byebug"

graph = File.read("input.dat").strip.split("\n").inject({}) do |h, row|
  row_nums = row.split(" ").map { |n| n.split(",").map(&:to_i) }
  vertex, edge_vertices = row_nums.shift.first, row_nums[1..-1]

  h[vertex] = row_nums
  h
end

source_vertex = 1
processed_vertices = Set.new([source_vertex])
shortest_distances = {}
shortest_distances[source_vertex] = 0

while processed_vertices.size < graph.size do
  next_vertex = nil
  next_dijkstra_value = nil

  processed_vertices.each do |processed_vertex|
    vertex_value = shortest_distances[processed_vertex]

    unprocessed_vertices = graph[processed_vertex].select { |head_vertex, length| !processed_vertices.member?(head_vertex) }

    next if unprocessed_vertices.empty?

    head_vertex, length = unprocessed_vertices.min_by do |head_vertex, length|
      vertex_value + length
    end

    if next_vertex.nil?
      next_vertex = head_vertex
      next_dijkstra_value = vertex_value + length
    end

    if vertex_value + length < next_dijkstra_value
      next_vertex = head_vertex
      next_dijkstra_value = vertex_value + length
    end
  end

  processed_vertices.add(next_vertex)
  shortest_distances[next_vertex] = next_dijkstra_value
end

pp "7,37,59,82,99,115,133,165,188,197".split(",").map(&:to_i).map { |n| shortest_distances[n] }.join(",")
