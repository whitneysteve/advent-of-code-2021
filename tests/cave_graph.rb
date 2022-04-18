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

  def test_larger_path_detection
    graph = CaveGraph.new(TEST_LARGER_EDGES)
    assert_equal 19, graph.paths.size
  end

  def test_largest_path_detection
    graph = CaveGraph.new(TEST_LARGEST_EDGES)
    assert_equal 226, graph.paths.size
  end

  # nil, empty
  def test_invalid_input; end

  # nil, '', ' ', '-a', 'a-'
  def test_invalid_edge; end
end
