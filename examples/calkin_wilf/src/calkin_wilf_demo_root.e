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
			print_n (100)
		end

feature -- Access

	tree: CALKIN_WILF
			-- The Calkin-Wilf enumeration of the rationals

feature -- Basic operations

	print_n (a_n: NATURAL)
			-- Print first `a_n' rationals, according to the Calkin-Wilf breadth-first 
			-- traversal.
		do
			from
				tree.start
			until
				tree.index.to_natural_32 > a_n
			loop
				print_value (tree.item)
				tree.forth
			end
		end

feature {NONE} -- Agents

	print_value (a_node: LAZY_BINARY_TREE [GMP_RATIONAL])
			-- Print the rational value in `a_node'.
		do
			print (a_node.item.out + "%N")
		end
	
end
