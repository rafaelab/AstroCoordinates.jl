export 
	ProjectionAitoffHammer

# ----------------------------------------------------------------------------------------------- #
#
@doc """
UNTESTED
"""
mutable struct ProjectionAitoffHammer{T, C <: Union{AbstractCoordinatesSky, AbstractGeoCoordinates}} <: AbstractProjection{T} 
	coordinates::Vector{C}
	function ProjectionAitoffHammer(coordinates::Vector{C}) where {C <: Union{AbstractCoordinatesSky, AbstractGeoCoordinates}}
		U = eltype(first(coordinates))
		return new{U, C}(coordinates)
	end
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Given a latitude and longitude, returns the x, y and z coordinates corresponding to the aitoff projection.

# Input
. `Type{ProjectionAitoffHammer}` \\
. `coords::Union{AbstractCoordinatesSky, AbstractGeoCoordinates}`:: any coordinate system defined on the sphere \\
"""
function convertToPlotCoordinates(::Type{ProjectionAitoffHammer}, coords::C) where {C <: Union{AbstractCoordinatesSky, AbstractGeoCoordinates}}
	φ = getLongitude(coords)
	λ = 90. * u"°" - getLatitude(coords)
	z = sqrt(1. + cos(λ) * cos(φ / 2.))

	u = unit(getLatitude(coords))

	x0 = ustrip(180. * u"°" |> u)
	y0 = ustrip(90. * u"°" |> u)
	x = x0 * cos(λ) * sin(φ / 2.) / z
	y = y0 * sin(λ) / z

	return x, y
end


# ----------------------------------------------------------------------------------------------- #
