note

	description: "[
		Infinite binary trees.
		Children are evaluated by a pair of agents (one for the left node, one for the right node)
	]"

	documentation: "https://en.wikipedia.org/wiki/Calkin-Wilf_tree"

class LAZY_BINARY_TREE [G]

create

	make

feature {NONE} -- Initialization

	make (a_value: attached G;
		a_parent: detachable LAZY_BINARY_TREE [G];
		a_left, a_right: FUNCTION [LAZY_BINARY_TREE [G], LAZY_BINARY_TREE [G]])
			-- Initialize attributes.
		do
			item := a_value
			left_child_function := a_left
			right_child_function := a_right
			parent := a_parent
		ensure
			item_aliased: item = a_value
			parent_aliased: parent = a_parent
			left_child_function_aliased: left_child_function = a_left
			right_child_function_aliased: right_child_function = a_right
		end

feature -- Access

	item: attached G
			-- Value at `Current' node

	parent: detachable LAZY_BINARY_TREE [G]
			-- Parent node, if not `is_root'

	left_child_function: FUNCTION [LAZY_BINARY_TREE [G], LAZY_BINARY_TREE [G]]
			-- Function to return left child of `Current'

	right_child_function: FUNCTION [LAZY_BINARY_TREE [G], LAZY_BINARY_TREE [G]]
			-- Function to return right child of `Current'

	is_root: BOOLEAN
			-- Is this the root node of the tree?
		do
			Result := not attached parent
		ensure
			definition: Result = not attached parent
		end

	left_child: LAZY_BINARY_TREE [G]
			-- First child of `Current'
		do
			Result := left_child_function (Current)
		end

	right_child: LAZY_BINARY_TREE [G]
			-- Second child of `Current'
		do
			Result := right_child_function (Current)
		end
	
end

	
