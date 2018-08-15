require "pp"
require "set"
require "byebug"

BITS_PER_NODE = 24

nodes = File.read("input_2.dat").strip.split("\n")[1..-1].map { |r| r.split(" ").join("").to_i(2) }
vertices = {}
nodes_hash = nodes.each_with_index.inject({}) do |h, (n, i)|
  vertices[i] = n
  h[n] ||= []
  h[n].push(i)
  h
end

cluster_vertices = {}
vertex_clusters = nodes.each_with_index.inject({}) do |h, (v, i)|
  h[i] = i
  cluster_vertices[i] = [i]
  h
end

one_bit_diff_masks = BITS_PER_NODE.times.map { |i| 2 ** i }
two_bit_diff_masks = BITS_PER_NODE.times.inject([]) do |masks, i|
  BITS_PER_NODE.times do |j|
    next if i == j

    masks.push(2 ** i + 2 ** j)
  end

  masks
end

edges = []

# 0 bit diff
nodes.each_with_index do |n, i|
  if nodes_hash[n].size > 1
    nodes_hash[n].each do |j|
      edges.push([i, j, 0]) unless i == j
    end
  end
end

puts "0: #{edges.size}"

# 1 bit diff
nodes.each_with_index do |n, i|
  one_bit_diff_masks.each do |m|
    head_node = n ^ m

    if nodes_hash.has_key?(head_node)
      nodes_hash[head_node].each do |j|
        edges.push([i, j, 1]) unless i == j
      end
    end
  end
end

puts "1: #{edges.size}"

# 2 bits diff
nodes.each_with_index do |n, i|
  two_bit_diff_masks.each do |m|
    head_node = n ^ m

    if nodes_hash.has_key?(head_node)
      nodes_hash[head_node].each do |j|
        edges.push([i, j, 2]) unless i == j
      end
    end
  end
end

puts "2: #{edges.size}"

while edges.any? do
  v1, v2, distance = edges.shift

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

puts cluster_vertices.size
