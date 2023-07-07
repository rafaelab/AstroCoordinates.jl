export 
	getLatitude,
	getLongitude


# ---------------------------------------------------------------------------------- #
#
@doc """
Sky coordinate systems (e.g., galactic, equatorial, etc).
"""
abstract type AbstractCoordinatesSky{T}  end


# ---------------------------------------------------------------------------------- #
#
# Define hidden strings to be used for the documentation of the function `getLongitude` and `getLatitude`.
const _docs_getLatitude_str = "\tgetLatitude(coordinateSystem)\n\nGet the coordinate corresponding to the latitude for a given coordinate system."
const _docs_getLongitude_str = "\tgetLongitude(coordinateSystem)\n\nGet the coordinate corresponding to the longitude for a given coordinate system."

# ---------------------------------------------------------------------------------- #
#
include("celestial/cartesian.jl")
include("celestial/icrs.jl")
include("celestial/equatorial.jl")
include("celestial/galactic.jl")
include("celestial/supergalactic.jl")
# include("celestial/ecliptic.jl")
include("celestial/horizontal.jl")
include("celestial/utilities.jl")
include("celestial/transformations.jl")
include("celestial/io.jl")

# ---------------------------------------------------------------------------------- #
#
@doc """
Data type of the coordinate system.
"""
Base.eltype(coords::AbstractCoordinatesSky{T}) where {T} = T


# ---------------------------------------------------------------------------------- #



