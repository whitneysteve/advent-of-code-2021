# frozen_string_literal: true

# Class to graph the ways out of a cave.
class CaveGraph
  attr_accessor :nodes

  def initialize(edges)
    populate_graph(edges)
  end

  def paths
    @paths ||= begin
      found_paths = []
      traverse(@nodes['start'], GraphPath.new, found_paths)
      found_paths
    end
  end

  private

  def traverse(node, current_path, paths)
    if node.name == 'end'
      paths << current_path.cut
    else
      options = next_step_options(node, current_path)
      if !options.empty?
        current_path.add(node)
        options.each { |option| traverse(option, current_path, paths) }
        current_path.pop
      end
    end
  end

  # rubocop:disable Metrics/AbcSize
  def populate_graph(edges)
    @nodes = {}
    edges.map { |edge| edge.split('-') }.each do |to, from|
      @nodes[to] = GraphNode.new(to) if !@nodes.key?(to)
      @nodes[from] = GraphNode.new(from) if !@nodes.key?(from)
      @nodes[to].add_edge(@nodes[from])
      @nodes[from].add_edge(@nodes[to])
    end
  end
  # rubocop:enable Metrics/AbcSize

  def next_step_options(node, current_path)
    node.connected_nodes.select { |connected| current_path.can_visit?(connected) }
  end
end

# Class to represent a node in a graph (for the connected cave system).
class GraphNode
  attr_reader :name, :edges

  def initialize(name)
    @name = name
    @edges = {}
  end

  def add_edge(node)
    @edges[node.name] = node if !@edges.key?(node.name)
  end

  def connected_nodes
    @edges.values
  end
end

# Class to represent a path through graph (for the connected cave system).
class GraphPath
  def initialize
    @path = []
    @visited = {}
  end

  def add(node)
    @path << node
    name = node.name
    @visited[name] = if @visited.key?(name)
                       @visited[name] + 1
                     else
                       1
                     end
  end

  def pop
    name = @path.pop&.name
    return if name.nil?

    if @visited[name] == 1
      @visited.delete(name)
    else
      @visited[name] = @visited[name] - 1
    end
  end

  def cut
    @path.map(&:name)
  end

  def can_visit?(node)
    name = node.name
    name != 'start' && (/^[A-Z]+$/.match?(node.name) || !@visited.key?(node.name))
  end

  def to_s
    @path.map(&:name).join(',').to_s
  end
end
