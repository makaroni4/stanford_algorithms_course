require "pp"
require "set"

graph = {}
reversed_graph = {}

File.read("small_input.dat")
    .strip
    .split("\n")
    .each do |row|
      n1, n2 = row.split(" ").map(&:to_i)
      graph[n1] ||= []
      graph[n1].push(n2)

      reversed_graph[n2] ||= []
      reversed_graph[n2].push(n1)
    end

@t = 0
@finishing_time = {}
@explored_nodes = Set.new
@ordered_nodes = []
@leader_node = nil
@leaders = {}

def dfs_one(graph, current_node)
  stack = [current_node]

  while stack.any? do
    n = stack.pop

    if @explored_nodes.member?(n)
      @t += 1
      @finishing_time[n] = @t
      @ordered_nodes.push(n)
    else
      next if graph[n].nil?
      @explored_nodes.add(n)

      nodes_to_explore = graph[n].select do |node|
        !@explored_nodes.member?(node)
      end

      if nodes_to_explore.any?
        stack.push(n)
        stack.concat(nodes_to_explore)
      else
        @t += 1
        @finishing_time[n] = @t
        @ordered_nodes.push(n)
      end
    end
  end
end

def dfs_two(graph, current_node)
  stack = [current_node]

  while stack.any? do
    n = stack.pop

    next if @explored_nodes.member?(n)
    next if graph[n].nil?

    @explored_nodes.add(n)
    @leaders[@leader_node] ||= []
    @leaders[@leader_node].push(n)

    graph[n].each do |node|
      stack.push(node) unless @explored_nodes.member?(node)
    end
  end
end

max_node = graph.keys.max
min_node = graph.keys.min

puts "--> dfs 1"
max_node.downto(min_node) do |node|
  next unless reversed_graph.has_key?(node)

  dfs_one(reversed_graph, node) unless @explored_nodes.member?(node)
end

# pp @t
# pp @finishing_time
# pp @ordered_nodes

@explored_nodes = Set.new

puts "--> dfs 2"

while @ordered_nodes.any? do
  node = @ordered_nodes.pop

  unless @explored_nodes.member?(node)
    @leader_node = node
    dfs_two(graph, node)
  end
end

scc_sizes = @leaders.keys.map do |leader_node|
  [leader_node, @leaders[leader_node].size]
end

pp scc_sizes.sort_by(&:last).reverse
