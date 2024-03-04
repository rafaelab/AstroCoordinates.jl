export 
	CoordinatesEquatorial,
	getRightAscension,
	getDeclination

# ----------------------------------------------------------------------------------------------- #
#
@doc """
Conversion from ICRS to the dynamical mean equator and equinox J2000.0 (barycentric).

# Reference
	"The IAU Resolutions on Astronomical Reference Systems, Time Scales, and Earth Rotation Models"
	G. H. Kaplan
	US Naval Observatory Circular #179
	astro-ph/0602086
	https://aa.usno.navy.mil/downloads/Circular_179.pdf
"""
const η0 = -6.8192 / 1000. * u"arcsecond" |> u"°"
const ξ0 = -16.6170 / 1000. * u"arcsecond" |> u"°"
const dα0 =  -14.6 / 1000. * u"arcsecond" |> u"°"
const matrixICRS2Equatorial = RotXYZ(η0, -ξ0, -dα0)
	

# ----------------------------------------------------------------------------------------------- #
#
@doc """

Convention: angles are measured in the range [0°, 360°).

# Reference:
	https://aa.usno.navy.mil/downloads/Circular_179.pdf

# Members
. `α::Angle{T}`: right ascension \\
. `δ::Angle{T}`: declination \\
"""
struct CoordinatesEquatorial{T} <: AbstractCoordinatesSky{T}
	α::Angle{T}
	δ::Angle{T}
	function CoordinatesEquatorial(α::Angle{U}, δ::Angle{U}) where {U}
		return new{U}(α, δ)
	end
end


CoordinatesEquatorial(α::Angle{Α}, δ::Angle{Δ}) where {Α, Δ} = CoordinatesEquatorial(promote(α, δ)...)

CoordinatesEquatorial(α::Real, δ::Real) = CoordinatesEquatorial(α * u"°", δ * u"°")


# ----------------------------------------------------------------------------------------------- #
#
getRightAscension(coord::CoordinatesEquatorial) = coord.α
getDeclination(coord::CoordinatesEquatorial) = coord.δ

# ----------------------------------------------------------------------------------------------- #
#
@doc """
$(_docs_getLongitude_str)
"""
getLongitude(coord::CoordinatesEquatorial) = coord.α


# ----------------------------------------------------------------------------------------------- #
#
@doc """
$(_docs_getLatitude_str)
"""
getLatitude(coord::CoordinatesEquatorial) = coord.δ


# ----------------------------------------------------------------------------------------------- #