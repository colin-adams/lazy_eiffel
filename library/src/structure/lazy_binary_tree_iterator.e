note

	description: "[
		Iterators over binary trees of potentially infinite depth.
	]"

deferred class LAZY_BINARY_TREE_ITERATOR [G]

inherit

	ITERATION_CURSOR [LAZY_BINARY_TREE [G]]
	
feature -- Status report	

	after: BOOLEAN
			-- Are there no more items to iterate over?
		do
			-- False
		end

feature -- Cursor movement

	start
			-- Move to first position.
		deferred
		end

end

	
