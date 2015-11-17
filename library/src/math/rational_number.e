note

	description: "[
		Approximation of rational numbers
		(uses class INTEGER rather than true integers)
	]"

class RATIONAL_NUMBER

inherit

	NUMERIC
		redefine
			is_equal, out
		end

create

	make

feature {NONE} -- Initialization

	make (a_num, a_denom: INTEGER)
			-- Create current as the reduction of `a_num' \ `a_denom' to 
			-- lowest common terms.
		local
			l_gcd: INTEGER
		do
			l_gcd := gcd (a_num.abs, a_denom.abs).max (1)
			numerator := a_num // l_gcd
			denominator := a_denom // l_gcd
		end

feature -- Access

	Numerator: INTEGER
			-- Numerator of `Current' (expressed in lowest terms)

	Denominator: INTEGER
			-- Denominator of `Current' (expressed in lowest terms)

	one: like Current
			-- <Precursor>
		do
			create Result.make (1, 1)
		end

	zero: like Current
			-- <Precursor>
		do
			create Result.make (0, 1)
		end

feature -- Comparison

	is_equal (a_other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := numerator ~ a_other.numerator and denominator ~ a_other.denominator
		end
	
feature -- Status report

	divisible (a_other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := a_other.numerator /= 0
		end

	exponentiable (a_other: NUMERIC): BOOLEAN
			--  Obsolete - not used
		do
		end

feature -- Basic operations

	plus alias "+" (a_other: like Current): like Current
			--  <Precursor>
		do
			create Result.make (numerator * a_other.denominator + a_other.numerator * denominator,
				denominator * a_other.denominator)
		end

	minus alias "-" (a_other: like Current): like Current
			--  <Precursor>
		do
			create Result.make (numerator * a_other.denominator - a_other.numerator * denominator,
				denominator * a_other.denominator)
		end

	product alias "*" (a_other: like Current): like Current
			--  <Precursor>
		do
			create Result.make (numerator * a_other.numerator,
				denominator * a_other.denominator)
		end

	quotient alias "/" (a_other: like Current): like Current
			--  <Precursor>
		do
			create Result.make (numerator * a_other.denominator,
				denominator * a_other.numerator)
		end

	identity alias "+": like Current
			--  <Precursor>
		do
			Result := Current
		end
	
	opposite alias "-": like Current
			--  <Precursor>
		do
			create Result.make (-numerator, denominator)
		end

feature -- Conversion

	to_double: REAL_64
			-- Approximation of real number equivalent
		do
			if denominator /= 0.0 then
				Result := numerator / denominator
			else
				Result := (0.0).Nan
			end
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := numerator.out + "/" + denominator.out
		end
	
feature {NONE} -- Implementation

	gcd (a_first, a_second: INTEGER): INTEGER
			-- Greatest common divisor of `a_first' and `a_second',
			--  by Euclid's algorithm
		do
			if a_first = a_second then
				Result := a_first
			elseif a_first = 1 or a_second = 1 then
				Result := 1
			elseif a_first = 0 then
				Result := a_second
			elseif a_second = 0 then
				Result := a_first
			elseif a_first <= a_second then
				Result := gcd (a_first, a_second \\ a_first)
			else
				Result := gcd (a_second, a_first \\ a_second)
			end
		end

end

