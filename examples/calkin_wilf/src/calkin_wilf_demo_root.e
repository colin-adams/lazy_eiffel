note

	description : "[
		Root class for demonstrating iteration of the rationals
		by breadth-first traversal of the Calkin-Wilf tree
		]"


class	CALKIN_WILF_DEMO_ROOT

inherit

	ARGUMENTS

create

	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			create tree.make
			create iterator.set (tree)
			print_n (100)
		end

feature -- Access

	tree: CALKIN_WILF
			-- The Calkin-Wilf enumeration of the rationals

	iterator: LINEAR_ITERATOR [LAZY_BINARY_TREE [RATIONAL_NUMBER]]
			-- Breadth-first traversal of the Calkin-Wilf tree
	
feature -- Basic operations

	print_n (a_n: NATURAL)
			-- Print first `a_n' rationals, according to the Calkin-Wilf breadth-first 
			-- traversal.
		do
			iterator.do_until (agent print_value, agent after_nth (?, a_n.as_integer_32))
		end

feature {NONE} -- Agents

	print_value (a_node: LAZY_BINARY_TREE [RATIONAL_NUMBER])
			-- Print the rational value in `a_node'.
		do
			print (a_node.item.out + "%N")
		end
	
	after_nth (a_node: LAZY_BINARY_TREE [RATIONAL_NUMBER]; a_nth: INTEGER): BOOLEAN
			-- Is `a_node' beyond the `a_nth' node?
		do
			Result := iterator.target.index > a_nth
		end
	
end
