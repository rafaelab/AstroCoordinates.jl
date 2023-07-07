export 
	CoordinatesSuperGalactic


# ---------------------------------------------------------------------------------- #
#
@doc """
Galactic coordinates of the north supergalactic pole (NSGP) and the supergalactic plane origin (0SGP).
For completeness, the corresponding equatorial (J2000) coordinates of the NSGP are also defined.

# Reference
	"The Supergalactic Plane revisited with the Optical Redshift Survey"
	O. Lahav et al.
    Monthly Notices of the Royal Astronomical Society 312 (2000) 166
	astro-ph/9809343
"""
const l_NSGP = 47.37 * u"°" 
const b_NSGP = 6.32 * u"°" 
const l_0SGP = 90. * u"°" + l_NSGP 
const b_0SGP = 0. * u"°" 
const α_NSGP = 283.5 * u"°" 
const δ_NSGP = 15.7 * u"°" 
const matrixSuperGalactic2Galactic = SMatrix{3, 3, Float64}(
	cos(l_0SGP) * cos(b_0SGP), sin(l_0SGP) * cos(b_0SGP), sin(b_0SGP), 
	sin(l_NSGP) * cos(b_NSGP) * sin(b_0SGP) - sin(b_NSGP) * sin(l_0SGP) * cos(b_0SGP), sin(b_NSGP) * cos(l_0SGP) * cos(b_0SGP) - cos(l_NSGP) * cos(b_NSGP) * sin(b_0SGP), cos(b_NSGP) * cos(b_0SGP) * sin(l_0SGP - l_NSGP), 
	cos(l_NSGP) * cos(b_NSGP), sin(l_NSGP) * cos(b_NSGP), sin(b_NSGP)
	)


# ---------------------------------------------------------------------------------- #
#
@doc """
This coordinate system is based on our local supercluster.

NOT WORKING!!!!!

# Reference
	"The Supergalactic Plane revisited with the Optical Redshift Survey"
	O. Lahav et al.
	Monthly Notices of the Royal Astronomical Society 312 (2000) 166
	arXiv:astro-ph/9809343
"""
struct CoordinatesSuperGalactic{T} <: AbstractCoordinatesSky{T}
	l::Angle{T}
	b::Angle{T}
	function CoordinatesSuperGalactic(l::Angle{U}, b::Angle{U}) where {U}
		return new{U}(l, b)
	end
end

CoordinatesSuperGalactic(l::Angle{L}, b::Angle{B}) where {L, B} = CoordinatesSuperGalactic(promote(l, b)...)

CoordinatesSuperGalactic(l::Real, b::Real) = CoordinatesSuperGalactic(l * u"°", b * u"°")

# ---------------------------------------------------------------------------------- #
#
@doc """
$(_docs_getLongitude_str)
"""
getLongitude(coord::CoordinatesSuperGalactic) = coord.l


# ---------------------------------------------------------------------------------- #
#
@doc """
$(_docs_getLatitude_str)
"""
getLatitude(coord::CoordinatesSuperGalactic) = coord.b

# ---------------------------------------------------------------------------------- #