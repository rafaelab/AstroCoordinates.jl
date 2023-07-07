export 
	CoordinatesGalactic

# ---------------------------------------------------------------------------------- #
#
@doc """
Galactic longitude of the north celestial pole (NCP).

# Reference (page ~900)
	"An Introduction to Modern Astrophysics"
	B. Carroll, D. Ostlie
	2017, 2nd edition
	Pearson Addison-Wesley
"""
const l_NCP = 122.9319185680026 * u"°" # galactic longitude of celestial equator

# ---------------------------------------------------------------------------------- #
#
@doc """
Equatorial coordinates (J2000) of the galactic north pole (NGP).

# Reference
	"Galactic Dynamics"
	J. Binney, S. Tremaine
	2008, 2nd edition
	Princeton University Press
"""
const α_NGP = 192.8594812065348 * u"°"
const δ_NGP = 27.12825118085622 * u"°"


# ---------------------------------------------------------------------------------- #
#
@doc """
The Galactic coordiante system is centred at the Sun. 
The Galactic plane is assumed to be located at the equator.
Convention: angles are measured in the range [0°, 360°).
Another convention is available, in which angles are measured in range [-180°, 180°).

# Members
. `l::Angle{T}`: Galactic longitude \\
. `b::Angle{T}`: Galactic latitude \\
"""
struct CoordinatesGalactic{T} <: AbstractCoordinatesSky{T}
	l::Angle{T}
	b::Angle{T}
	function CoordinatesGalactic(l::Angle{U}, b::Angle{U}) where {U}
		return new{U}(l, b)
	end
end

CoordinatesGalactic(l::Angle{L}, b::Angle{B}) where {L, B} = CoordinatesGalactic(promote(l, b)...)

CoordinatesGalactic(l::Real, b::Real) = CoordinatesGalactic(l * u"°", b * u"°")


# ---------------------------------------------------------------------------------- #
#
@doc """
$(_docs_getLongitude_str)
"""
getLongitude(coord::CoordinatesGalactic) = coord.l


# ---------------------------------------------------------------------------------- #
#
@doc """
$(_docs_getLatitude_str)
"""
getLatitude(coord::CoordinatesGalactic) = coord.b


# ---------------------------------------------------------------------------------- #
#