export 
	CoordinatesICRS,
	getRightAscension,
	getDeclination

# ---------------------------------------------------------------------------------- #
#
@doc """
The International Celestial Reference System (ICRS) is adopted by IAU.
The origin of this coordinate system is at the barycenter of the Solar System.
Because it is rooted on extragalactic observations, this frame doesn't change with Earth's motion.

# Reference
	"The IAU Resolutions on Astronomical Reference Systems, Time Scales, and Earth Rotation Models"
	G. H. Kaplan
	US Naval Observatory Circular #179
	astro-ph/0602086
	https://aa.usno.navy.mil/downloads/Circular_179.pdf

# Members
. `α::Angle{T}`: right ascension \\
. `δ::Angle{T}`: declination \\
"""
struct CoordinatesICRS{T} <: AbstractCoordinatesSky{T}
	α::Angle{T}
	δ::Angle{T}
	function CoordinatesICRS(α::Angle{U}, δ::Angle{U}) where {U}
		return new{U}(α, δ)
	end
end

CoordinatesICRS(α::Angle{Α}, δ::Angle{Δ}) where {Α, Δ} = CoordinatesICRS(promote(α, δ)...)

CoordinatesICRS(α::Real, δ::Real) = CoordinatesICRS(α * u"°", δ * u"°")


# ---------------------------------------------------------------------------------- #
#
getRightAscension(coord::CoordinatesICRS) = coord.α
getDeclination(coord::CoordinatesICRS) = coord.δ

# ---------------------------------------------------------------------------------- #
#
@doc """
$(_docs_getLongitude_str)
"""
getLongitude(coord::CoordinatesICRS) = coord.α


# ---------------------------------------------------------------------------------- #
#
@doc """
$(_docs_getLatitude_str)
"""
getLatitude(coord::CoordinatesICRS) = coord.δ

# ---------------------------------------------------------------------------------- #