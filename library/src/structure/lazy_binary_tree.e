note

	description: "[
		Binary trees of potentially infinite depth.
	]"

class LAZY_BINARY_TREE [G]

inherit

	LAZY_TREE [G]
	
create

	make

feature {NONE} -- Initialization

	make (a_value: attached G;
		a_parent: detachable LAZY_BINARY_TREE [G];
		a_child_function: like child_function)
			-- Initialize attributes.
		do
			item := a_value
			child_function := a_child_function
			parent := a_parent
		ensure
			item_aliased: item = a_value
			parent_aliased: parent = a_parent
			child_function_aliased: child_function = a_child_function
		end

feature -- Access

	left_child: LAZY_BINARY_TREE [G]
			-- First child of `Current'
		do
			Result := n_th_child (1)
		end

	right_child: LAZY_BINARY_TREE [G]
			-- Second child of `Current'
		do
			Result := n_th_child (2)
		end

feature -- Measurement

	count: NATURAL = 2
			-- Number of immediate children

end

	
