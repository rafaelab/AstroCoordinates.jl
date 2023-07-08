export 
	getLatitude,
	getLongitude,
	getAltitude

# ---------------------------------------------------------------------------------- #
#
@doc """
"""
abstract type AbstractGeoCoordinates end


# ---------------------------------------------------------------------------------- #
#
include("earth/geocentric.jl")
include("earth/geodetic.jl")

# # = λG + (xp sin λG + yp cos λG) tan φG /360


# ---------------------------------------------------------------------------------- #
#
@doc """
Get latitude.
"""
getLatitude(geocoord::AbstractGeoCoordinates) = geocoord.λ


# ---------------------------------------------------------------------------------- #
#
@doc """
Get longitude.
"""
getLongitude(geocoord::AbstractGeoCoordinates) = geocoord.φ


# ---------------------------------------------------------------------------------- #
#
@doc """
Get altitude.
"""
getAltitude(geocoord::AbstractGeoCoordinates) = geocoord.a

# ---------------------------------------------------------------------------------- #