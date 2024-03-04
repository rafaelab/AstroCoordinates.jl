export 
	CoordinatesEcliptic


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Angle referring to the Earth's axis of rotation with respect to the orbital plane of the Earth around the Sun.
Due to perturbations, this angle is decreasing ~0.01° per century.

# Reference
	"Astronomical Algorithms"
	J. Meeus
	1998, 2nd edition
	willmann-Bell

Newcomb, Simon (1906). A Compendium of Spherical Astronomy. MacMillan Co., New York., p. 226-227, at Google books
"""
const ε_o =  23.439291111 * u"°"


# ----------------------------------------------------------------------------------------------- #
#
@doc """
This coordinate system used the plane of the ecliptic as a reference.

UNTESTED!
"""
struct CoordinatesEcliptic{T} <: AbstractCoordinatesSky{T}
	λ::Angle{T}
	β::Angle{T}
	function CoordinatesEcliptic(λ::Angle{U}, β::Angle{U}) where {U}
		return new{U}(λ, β)
	end
end

CoordinatesEcliptic(λ::Angle{Λ}, β::Angle{Β}) where {Λ, Β} = CoordinatesEcliptic(promote(λ, β)...)

CoordinatesEcliptic(λ::Real, β::Real) = CoordinatesEcliptic(λ * u"°", β * u"°")


# ----------------------------------------------------------------------------------------------- #
#
@doc """
$(_docs_getLongitude_str)
"""
getLongitude(coord::CoordinatesEcliptic) = coord.λ


# ----------------------------------------------------------------------------------------------- #
#
@doc """
$(_docs_getLatitude_str)
"""
getLatitude(coord::CoordinatesEcliptic) = coord.β


# ----------------------------------------------------------------------------------------------- #