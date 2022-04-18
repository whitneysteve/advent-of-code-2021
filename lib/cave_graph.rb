# frozen_string_literal: true

# Class to graph the ways out of a cave.
class CaveGraph
  attr_accessor :nodes

  def initialize(edges, visit_twice: false)
    raise 'InvalidGraph' if !edges.is_a?(Array) || edges.empty?

    populate_graph(edges)
    @visit_twice = visit_twice
  end

  def paths
    @paths ||= begin
      found_paths = []
      traverse(@nodes['start'], GraphPath.new(@visit_twice), found_paths)
      found_paths
    end
  end

  private

  # rubocop:disable Metrics/MethodLength
  def traverse(node, current_path, paths)
    if node.name == 'end'
      paths << current_path.cut
    else
      options = next_step_options(node, current_path)
      if !options.empty?
        current_path.add(node)
        options.each do |option|
          traverse(option, current_path, paths) if current_path.can_visit?(option)
        end
        current_path.pop
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def populate_graph(edges)
    @nodes = {}
    edges.map { |edge| edge&.split('-') }.each do |to, from|
      raise 'InvalidEdge' if to.nil? || from.nil? || to.strip.size.zero? || from.strip.size.zero?

      @nodes[to] = GraphNode.new(to) if !@nodes.key?(to)
      @nodes[from] = GraphNode.new(from) if !@nodes.key?(from)
      @nodes[to].add_edge(@nodes[from])
      @nodes[from].add_edge(@nodes[to])
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

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
  def initialize(visit_twice_mode)
    @path = []
    @visited = {}
    @visit_twice_mode = visit_twice_mode
    @visit_twice_node = nil
  end

  def add(node)
    @path << node
    name = node.name
    @visited[name] = if @visited.key?(name)
                       @visit_twice_node = name if !upper_case_node?(name)
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

    @visit_twice_node = nil if @visit_twice_node == name
  end

  def cut
    @path.map(&:name)
  end

  def can_visit?(node)
    name = node.name
    return false if name == 'start'
    return true if upper_case_node?(name)

    !exhausted_visits?(name) || can_visit_twice?
  end

  def exhausted_visits?(name)
    @visited.key?(name)
  end

  def can_visit_twice?
    @visit_twice_mode && @visit_twice_node.nil?
  end

  def upper_case_node?(name)
    /^[A-Z]+$/.match?(name)
  end

  def to_s
    @path.map(&:name).join(',').to_s
  end
end
