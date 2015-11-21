note

	description: "[
		Trees of potentially infinite depth and finite fan-out.

		Children are evaluated by an agent. The agent must function correctly
		when passed a second argument in the range 0 < n <= `count'.
	]"

deferred class LAZY_TREE [G]

feature -- Access

	item: attached G
			-- Value at `Current' node

	parent: detachable like Current
			-- Parent node, if not `is_root'

	child_function: FUNCTION [like Current, NATURAL, like Current]
			-- Function to return nth child of `Current'

	is_root: BOOLEAN
			-- Is this the root node of the tree?
		do
			Result := not attached parent
		ensure
			definition: Result = not attached parent
		end

	n_th_child (a_n_th: NATURAL): like Current
			-- `a_n_th' child of `Current'
		require
			a_n_th_strictly_positive: a_n_th > 0
			a_n_th_small_enough: a_n_th <= count
		do
			Result := child_function (Current, a_n_th)
		end

feature -- Measurement

	count: NATURAL
			-- Number of immediate children
		deferred
		end

end

	
