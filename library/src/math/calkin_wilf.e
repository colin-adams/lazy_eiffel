note

	description: "[
		Calkin-Wilf trees.
		An infinite lazy data structure for enumerating the strictly-positive rationals.

		This implementation is not actually infinite, as class RATIONAL_NUMBER
		currently uses INTEGER for the numerator and denominator, so if
		you iterate far enough you get an exception (or if you navigate through the tree
		manually, eventually you will go somewhere you shouldn't).

		But we take advantage of that to inherit from LINEAR, which implements a breadth-first
		traversal over the rationals.
	]"

	documentation: "https://en.wikipedia.org/wiki/Calkin-Wilf_tree"

class CALKIN_WILF

inherit

	LINEAR [LAZY_BINARY_TREE [RATIONAL_NUMBER]]
		rename
			item as linear_item
		end

create

	make

feature {NONE} -- Initialization

	make
			-- Create `root'.
		do
			left_child_agent := agent left_child
			right_child_agent := agent right_child
			create root.make ((create {RATIONAL_NUMBER}.make (1, 1)), Void, left_child_agent, right_child_agent)
			start
		end

feature -- Access
	
	root: LAZY_BINARY_TREE [RATIONAL_NUMBER]
			-- 1/1

	linear_item: LAZY_BINARY_TREE [RATIONAL_NUMBER]
			-- <Precursor>

	left_child_agent: FUNCTION [LAZY_BINARY_TREE [RATIONAL_NUMBER], LAZY_BINARY_TREE [RATIONAL_NUMBER]]
			-- Function from a node to its left child

	right_child_agent: FUNCTION [LAZY_BINARY_TREE [RATIONAL_NUMBER], LAZY_BINARY_TREE [RATIONAL_NUMBER]]
			-- Function from a node to its left child

	left_child (a_node: LAZY_BINARY_TREE [RATIONAL_NUMBER]): LAZY_BINARY_TREE [RATIONAL_NUMBER]
			-- Left child of `a_node'
		do
			create Result.make (create {RATIONAL_NUMBER}.make (
				a_node.item.numerator, a_node.item.numerator + a_node.item.denominator),
				a_node, left_child_agent, right_child_agent)
		end

	right_child (a_node: LAZY_BINARY_TREE [RATIONAL_NUMBER]): LAZY_BINARY_TREE [RATIONAL_NUMBER]
			-- Right child of `a_node'
		do
			create Result.make (create {RATIONAL_NUMBER}.make (
				a_node.item.numerator + a_node.item.denominator, a_node.item.denominator),
				a_node, left_child_agent, right_child_agent)
		end

	index: INTEGER
			-- Index of current position

feature -- Status report

	is_empty: BOOLEAN
		-- Is there no element?
		
	after: BOOLEAN
			-- Is there no valid position to the right of current one? 

feature -- Cursor movement

	start
		-- Move to first position.
		do
			linear_item := root
			index := 1
		end
	
	finish
			-- Move to last position. Impossible!
		do
			finish -- :-)
		end

	forth
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		local
			l_binary: LINKED_LIST [BOOLEAN]
		do
			if index = index.max_value then
				(create {EXCEPTIONS}).raise ("Infinity!")
			else
				index := index + 1
				l_binary := binary_code (index)
				from
					l_binary.start
				until
					l_binary.item
				loop
					l_binary.remove
				end
				-- We have removed the leading 0 bits of `index'
				-- Since `index' > 0, we are guaranteed to have terminated
				-- Now we are looking at a `True', representing `root'
				from
					linear_item := root
					l_binary.remove
				until
					l_binary.after
				loop
					if l_binary.item then
						linear_item := linear_item.right_child
					else
						linear_item := linear_item.left_child
					end
					l_binary.remove
				end
			end
		end

feature {NONE} -- Implementation

	binary_code (a_index: INTEGER): LINKED_LIST [BOOLEAN]
			-- Instructions to reach node `a_index' starting from `root';
			-- (Bits of `a_index')
		require
			a_index_strictly_positive: a_index > 0
		local
			i: INTEGER
		do
			create Result.make
			from
				i := 31
			until
				i < 0
			loop
				Result.extend (a_index.bit_test (i))
				i := i - 1
			end
		end
	
invariant

	infinite: not after
	never_empty: not is_empty

end

