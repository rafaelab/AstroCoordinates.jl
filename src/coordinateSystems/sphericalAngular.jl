export 
	CoordinatesSphericalAngular,
	getCoordinates,
	getθ,
	getφ,
	getR,
	getRadius,
	getAzimuth,
	getZenith
	
	

# ----------------------------------------------------------------------------------------------- #
#
@doc """
Defines a spherical coordinate system on the unit sphere.
The convention adopted is: azimuth-zenith.
Note that units (anglular) may or may not be provided.
"""
struct CoordinatesSphericalAngular{T} <: AbstractCoordinatesSpherical
	coordinates::SVector{2, T}
	function CoordinatesSphericalAngular(v::SVector{2, T}) where {T}
		return new{T}(v)
	end
end

CoordinatesSphericalAngular(coords::Vector) = CoordinatesSphericalAngular(SVector{eltype(coords)}(coords))

CoordinatesSphericalAngular(φ::Φ, θ::Θ) where {Φ <: Real, Θ <: Real} = CoordinatesSphericalAngular(φ, θ)

CoordinatesSphericalAngular(coords::Tuple{Φ, Θ}) where {Φ, Θ} = CoordinatesSphericalAngular(coords...)


# ----------------------------------------------------------------------------------------------- #
#
@doc """ 
Function to get the vectors of coordinates for an object of type `CoordinatesSphericalAngular`.
"""
getCoordinates(coords::CoordinatesSphericalAngular) = coords.coordinates


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Get the coordinates by name for a given `CoordinatesSphericalAngular`.
"""
getR(coords::CoordinatesSphericalAngular) = missing
getφ(coords::CoordinatesSphericalAngular) = coords.φ
getθ(coords::CoordinatesSphericalAngular) = coords.θ
const getRadius = getR
const getAzimuth = getφ
const getZenith = getθ


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Add methods to get objects of type `CoordinatesSphericalAngular` by index.
"""
function Base.getindex(coords::CoordinatesSphericalAngular, i::Integer)
	if i == 1
		return getAzimuth(coords)
	elseif i == 2
		return getZenith(coords)
	else
		throw(DimensionMismatch("There are only 2 coordinates in type `CoordinatesSphericalAngular`."))
	end
end



# ----------------------------------------------------------------------------------------------- #
#
@doc """
Get the data type for an `CoordinatesSphericalAngular` object.
"""
Base.eltype(coords::CoordinatesSphericalAngular{T}) where {T} = T



# ----------------------------------------------------------------------------------------------- #
#