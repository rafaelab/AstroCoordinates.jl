# type to dispatch on
Angle{T} = Union{
	Unitful.Quantity{T, Unitful.NoDims, typeof(u"rad")}, 
	Unitful.Quantity{T, Unitful.NoDims, typeof(u"°")},
	Unitful.Quantity{T, Unitful.NoDims, typeof(u"hourAngle")},
	Unitful.Quantity{T, Unitful.NoDims, typeof(u"arcminute")},
	Unitful.Quantity{T, Unitful.NoDims, typeof(u"arcsecond")}
	} where {T}
Length{T} = Unitful.Length{T} where {T}



# ---------------------------------------------------------------------------------- #
#
@doc """
Generate a polynomial of the form:
	f(x) = a0 + a1 x + a2 x^2 + ...
"""
function createPolynomialFunction(coeff::Tuple)
	function polynomialFunction(x)
		y = 0.
		for i = 0 : length(coeff) - 1
			y += (coeff[i + 1] * (x ^ i)) 
		end
		return y
	end
	return polynomialFunction
end

createPolynomialFunction(coeff::AbstractVector) = createPolynomialFunction(Tuple(coeff))


# ---------------------------------------------------------------------------------- #
#
@doc """
Conversions from time to angles.
"""
Base.convert(::Type{A}, t::Time) where {A <: Angle} = (convert(u"hourAngle", t) |> u"°")

Base.convert(::Type{A}, dt::DateTime) where {A <: Angle} = convert(Angle, Time(dt))

Base.convert(::Type{Time}, a::Angle) = convert(Time, a)
	

# ---------------------------------------------------------------------------------- #