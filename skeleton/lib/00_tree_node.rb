class PolyTreeNode
    def initialize (value)
        @value = value
        @parent = nil
        @children = []
    end

    def value
        @value
    end

    def parent
        @parent
    end

    def children
        @children
    end

    def parent=(new_parent)
        if new_parent.nil?
            self.parent.children.delete(self)
            @parent = nil
        elsif !self.parent.nil?
            self.parent.children.delete(self)
            @parent = new_parent 
            new_parent.children << self
        else
            @parent = new_parent 
            new_parent.children << self
        end
    end

    def add_child(child_node)
        child_node.parent=(self)
    end

    def remove_child(child_node)
        child_node.parent=(nil)
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            if !child.dfs(target_value).nil?
                return child.dfs(target_value)
            end
        end
        nil
    end
end

       