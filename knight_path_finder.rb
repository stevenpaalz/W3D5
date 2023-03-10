require_relative "./skeleton/lib/00_tree_node.rb"
require "byebug"

class KnightPathFinder
    def self.root_node(pos)
        PolyTreeNode.new(pos)
    end

    def initialize(starting_pos)
        @initial_pos = KnightPathFinder.root_node(starting_pos)
        @considered_positions = [@initial_pos]
        self.build_move_tree
        # count = 0
        # @considered_positions.each do |node|
        #     count += 1
        #     p node.value
        # end
        # puts count
    end

    # this is the iteration
    def build_move_tree
        queue = @considered_positions.dup
        until @considered_positions.length == 64
            new_positions = self.new_move_positions(queue.shift())
            queue += new_positions
        end
        @considered_positions
    end


    def self.valid?(pos)
        x, y = pos
        return false if x < 0 || x > 7
        return false if y < 0 || y > 7
        true
    end

    def self.valid_moves(pos)
        x, y = pos.value
        results = []

        results << PolyTreeNode.new([x - 2, y + 1]) if KnightPathFinder.valid?([x - 2, y + 1])
        results << PolyTreeNode.new([x - 1, y + 2]) if KnightPathFinder.valid?([x - 1, y + 2])
        results << PolyTreeNode.new([x + 1, y + 2]) if KnightPathFinder.valid?([x + 1, y + 2])
        results << PolyTreeNode.new([x + 2, y + 1]) if KnightPathFinder.valid?([x + 2, y + 1])
        results << PolyTreeNode.new([x + 2, y - 1]) if KnightPathFinder.valid?([x + 2, y - 1])
        results << PolyTreeNode.new([x + 1, y - 2]) if KnightPathFinder.valid?([x + 1, y - 2])
        results << PolyTreeNode.new([x - 1, y - 2]) if KnightPathFinder.valid?([x - 1, y - 2])
        results << PolyTreeNode.new([x - 2, y - 1]) if KnightPathFinder.valid?([x - 2, y - 1])

        results.each do |node|
            node.parent=(pos)
        end
        results
        # results = results.map { |node| node.parent=(pos) }
    end

    # this is a step
    def new_move_positions(pos_node)

        new_positions = []
        KnightPathFinder.valid_moves(pos_node).each do |new_pos|
            if @considered_positions.none? {|considered_node| considered_node.value == new_pos.value }
                new_positions << new_pos
                @considered_positions << new_pos
            end
        end
        new_positions
    end

  def find_path(end_pos)
        @considered_positions.each do |node|
           return node if node.value == end_pos
        end
    end

    def trace_path_back(end_pos)
        results = []
        answered_node = find_path(end_pos)
        until answered_node.parent.nil?
            results.unshift(answered_node.value)
            answered_node = answered_node.parent
        end
        
        results.unshift(@initial_pos.value)
    end

        
end


# debugger
tst = KnightPathFinder.new([0,0])
p tst.trace_path_back([7,6])
# debugger
# p tst.find_path([6,2])
# tst.find_path([6,2]).children.each {|child| p child.value}