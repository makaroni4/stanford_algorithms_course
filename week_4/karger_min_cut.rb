vertices = Hash.new([])

File.read("input.txt").split("\n")
    .map { |row| row.split(" ").map(&:to_i) }
    .each do |row|
      vertex = row.shift

      vertices[vertex] = row
    end

def min_cut(vertices)
  while vertices.size > 2 do
    v1 = vertices.keys.sample
    v2 = vertices[v1].sample

    vertices[v1] += vertices[v2]

    vertices[v2].each do |v|
      vertices[v].map! { |vv| vv == v2 ? v1 : vv }
    end

    vertices[v1].delete(v1)
    vertices.delete(v2)
  end

  vertices.shift[1].size
end

min_cut_edges = vertices.size

1000.times do
  new_min_cut_edges = min_cut(Marshal.load(Marshal.dump(vertices)))

  if new_min_cut_edges < min_cut_edges
    min_cut_edges = new_min_cut_edges
    puts min_cut_edges
  end
end
