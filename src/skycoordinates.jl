export 
	getLatitude,
	getLongitude


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Sky coordinate systems (e.g., galactic, equatorial, etc).
"""
abstract type AbstractCoordinatesSky{T}  end


# ----------------------------------------------------------------------------------------------- #
#
# Define hidden strings to be used for the documentation of the function `getLongitude` and `getLatitude`.
const _docs_getLatitude_str = "\tgetLatitude(coordinateSystem)\n\nGet the coordinate corresponding to the latitude for a given coordinate system."
const _docs_getLongitude_str = "\tgetLongitude(coordinateSystem)\n\nGet the coordinate corresponding to the longitude for a given coordinate system."

# ----------------------------------------------------------------------------------------------- #
#
include("celestial/icrs.jl")
include("celestial/equatorial.jl")
include("celestial/galactic.jl")
include("celestial/supergalactic.jl")
include("celestial/horizontal.jl")
include("celestial/utilities.jl")
include("celestial/transformations.jl")
include("celestial/operations.jl")
include("celestial/io.jl")

# ----------------------------------------------------------------------------------------------- #
#
@doc """
Data type of the coordinate system.
"""
Base.eltype(coords::AbstractCoordinatesSky{T}) where {T} = T


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Convert types.
"""
function Base.convert(::Type{T}, coords::AbstractCoordinatesSky{U}) where {T <: Real, U}
	if T == U
		return coords
	else
		C = Base.typename(typeof(coords)).wrapper
		return C(T(getLongitude(coords)), T(getLatitude(coords)))
	end
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Define promotion rules.
"""
Base.promote_rule(::Type{CoordinatesEquatorial{T1}}, ::Type{CoordinatesEquatorial{T2}}) where {T1, T2} = CoordinatesEquatorial{promote_type(T1, T2)}
Base.promote_rule(::Type{CoordinatesGalactic{T1}}, ::Type{CoordinatesGalactic{T2}}) where {T1, T2} = CoordinatesGalactic{promote_type(T1, T2)}
Base.promote_rule(::Type{CoordinatesSuperGalactic{T1}}, ::Type{CoordinatesSuperGalactic{T2}}) where {T1, T2} = CoordinatesSuperGalactic{promote_type(T1, T2)}
Base.promote_rule(::Type{CoordinatesICRS{T1}}, ::Type{CoordinatesICRS{T2}}) where {T1, T2} = CoordinatesICRS{promote_type(T1, T2)}
# Base.promote_rule(::Type{CoordinatesEcliptic{T1}}, ::Type{CoordinatesEcliptic{T2}}) where {T1, T2} = CoordinatesEcliptic{promote_type(T1, T2)}





# ----------------------------------------------------------------------------------------------- #



