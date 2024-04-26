export 
	CoordinatesSpherical,
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
Defines a spherical coordinate system.
The convention adopted is: radius-azimuth-zenith.
For performance, no units are stored in the structure, although the angles are in degrees.
When they are explicitly called from the object, they are returned with units.
"""
struct CoordinatesSpherical{T}
	coordinates::SVector{3, T}
	function CoordinatesSpherical(v::SVector{3, T}) where {T}
		return new{T}(v)
	end
end

CoordinatesSpherical(coords::AbstractVector) = CoordinatesSpherical(SVector{eltype(coords)}(coords))

CoordinatesSpherical(coords::Tuple{R, Φ, Θ}) where {R, Φ, Θ} = CoordinatesSpherical(SVector{promote_type(R, Φ, Θ)}(coords))

CoordinatesSpherical(r::R, φ::Φ, θ::Θ) where {R, Φ, Θ} = CoordinatesSpherical(SVector{3, promote_type(R, Φ, Θ)}(r, φ, θ))

# ----------------------------------------------------------------------------------------------- #
#
@doc """
Implement `coords.r`, `coords.φ`, and `coords.θ` for easier access.
Note that
"""
function Base.getproperty(c::CoordinatesSpherical, v::Symbol)
	if v == :r
		return c.coordinates[1]
	elseif v == :φ
		return c.coordinates[2] * u"°"
	elseif v == :θ
		return c.coordinates[3] * u"°"
	else
		return getfield(c, v)
	end
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """ 
Function to get the vectors of coordinates for an object of type `CoordinatesSpherical`.
"""
getCoordinates(coords::CoordinatesSpherical) = coords.coordinates


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Get the coordinates by namefor a given `CoordinatesSpherical` or `CoordinatesSpherical`.
"""
getR(coords::CoordinatesSpherical) = coords.r
getφ(coords::CoordinatesSpherical) = coords.φ
getθ(coords::CoordinatesSpherical) = coords.θ
const getRadius = getR
const getAzimuth = getφ
const getZenith = getθ


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Get azimuthal angle.
"""
getAzimuth(coord::CoordinatesSpherical) = coord.φ


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Get zenith angle.
"""
getZenith(coord::CoordinatesSpherical) = coord.θ


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Add methods to get objects of type `CoordinatesSpherical` by index.
"""
Base.getindex(coords::CoordinatesSpherical, i::Integer) = getCoordinates(coords)[i]


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Get the data type for an `CoordinatesSpherical` object.
"""
Base.eltype(coords::CoordinatesSpherical{T}) where {T} = T



# ----------------------------------------------------------------------------------------------- #
#