require "set"
require "byebug"

input = File.read("input_1.dat").strip.split("\n")[1..-1].map { |r| r.split(" ").map(&:to_i) }

vertices = {}

input.each do |v1, v2, cost|
  vertices[v1] ||= []
  vertices[v1].push([v2, cost])

  vertices[v2] ||= []
  vertices[v2].push([v1, cost])
end

cluster_vertices = {}
vertex_clusters = vertices.keys.each_with_index.inject({}) do |h, (v, i)|
  h[v] = i
  cluster_vertices[i] = [v]
  h
end

input.sort_by!(&:last)

while cluster_vertices.size > 4 do
  v1, v2, distance = input.shift
  c1 = vertex_clusters[v1]
  c2 = vertex_clusters[v2]

  next if c1 == c2

  if cluster_vertices[c1].size > cluster_vertices[c2].size
    # c2 -> c1
    cluster_vertices[c2].each do |v|
      vertex_clusters[v] = c1
    end

    cluster_vertices[c1] = cluster_vertices[c1] + cluster_vertices[c2]
    cluster_vertices.delete(c2)
  else
    # c1 -> c2
    cluster_vertices[c1].each do |v|
      vertex_clusters[v] = c2
    end

    cluster_vertices[c2] = cluster_vertices[c1] + cluster_vertices[c2]
    cluster_vertices.delete(c1)
  end
end

input.each do |v1, v2, distance|
  c1 = vertex_clusters[v1]
  c2 = vertex_clusters[v2]

  next if c1 == c2

  puts distance
  break
end
