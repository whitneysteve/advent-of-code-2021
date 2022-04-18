# frozen_string_literal: true

require_relative '../lib/cave_graph'
require 'minitest/autorun'

# Test for cave graphing.
class CaveGraphTest < Minitest::Test
  TEST_EDGES = %w[
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
  ].freeze

  TEST_LARGER_EDGES = %w[
    dc-end
    HN-start
    start-kj
    dc-start
    dc-HN
    LN-dc
    HN-end
    kj-sa
    kj-HN
    kj-dc
  ].freeze

  TEST_LARGEST_EDGES = %w[
    fs-end
    he-DX
    fs-he
    start-DX
    pj-DX
    end-zg
    zg-sl
    zg-pj
    pj-he
    RW-he
    fs-DX
    pj-RW
    zg-RW
    start-pj
    he-WI
    zg-he
    pj-fs
    start-RW
  ].freeze

  def test_path_detection
    graph = CaveGraph.new(TEST_EDGES)
    assert_equal 10, graph.paths.size
  end

  def test_path_detection_visit_twice
    graph = CaveGraph.new(TEST_EDGES, visit_twice: true)
    assert_equal 36, graph.paths.size
  end

  def test_larger_path_detection
    graph = CaveGraph.new(TEST_LARGER_EDGES)
    assert_equal 19, graph.paths.size
  end

  def test_larger_path_detection_visit_twice
    graph = CaveGraph.new(TEST_LARGER_EDGES, visit_twice: true)
    assert_equal 103, graph.paths.size
  end

  def test_largest_path_detection
    graph = CaveGraph.new(TEST_LARGEST_EDGES)
    assert_equal 226, graph.paths.size
  end

  def test_largest_path_detection_visit_twice
    graph = CaveGraph.new(TEST_LARGEST_EDGES, visit_twice: true)
    assert_equal 3509, graph.paths.size
  end

  def test_invalid_input
    invalid_input = [nil, []]
    invalid_input.each do |invalid|
      error = assert_raises { CaveGraph.new(invalid) }
      assert_equal 'InvalidGraph', error.message
    end
  end

  def test_invalid_edge
    invalid_edges = [nil, '', ' ', '-a', 'a-']
    invalid_edges.each do |invalid|
      error = assert_raises { CaveGraph.new([invalid]).paths }
      assert_equal 'InvalidEdge', error.message
    end
  end
end
