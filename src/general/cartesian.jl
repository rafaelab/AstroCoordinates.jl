export 
	CoordinatesCartesian,
	getCoordinates,
	getX,
	getY,
	getZ
	

# ----------------------------------------------------------------------------------------------- #
#
@doc """
Defines a cartesian coordinate system on the sphere.
"""
struct CoordinatesCartesian{T}
	coordinates::SVector{3, T}
	function CoordinatesCartesian(v::SVector{3, T}) where {T}
		return new{T}(v)
	end
end

CoordinatesCartesian(coords::AbstractVector) = CoordinatesCartesian(SVector{eltype(coords)}(coords))

CoordinatesCartesian(coords::Tuple{X, Y, Z}) where {X, Y, Z} = CoordinatesCartesian(SVector{promote_type(X, Y, Z)}(coords))

CoordinatesCartesian(x::X, y::Y, z::Z) where {X, Y, Z} = CoordinatesCartesian(SVector{3, promote_type(X, Y, Z)}(x, y, z))

# ----------------------------------------------------------------------------------------------- #
#
@doc """
Implement `coords.x`, `coords.y`, and `coords.z` for easier access.
"""
function Base.getproperty(c::CoordinatesCartesian, v::Symbol)
	if v == :x
		return c.coordinates[1]
	elseif v == :y
		return c.coordinates[2]
	elseif v == :z
		return c.coordinates[3]
	else
		return getfield(c, v)
	end
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """ 
Function to get the vectors of coordinates for an object of type `CoordinatesCartesian`.
"""
getCoordinates(coords::CoordinatesCartesian) = coords.coordinates


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Get the coordinates by namefor a given `CoordinatesCartesian` or `CoordinatesSpherical`.
"""
getX(coords::CoordinatesCartesian) = coords.x
getY(coords::CoordinatesCartesian) = coords.y
getZ(coords::CoordinatesCartesian) = coords.z


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Add methods to get objects of type `CoordinatesCartesian` by index.
"""
Base.getindex(coords::CoordinatesCartesian, i::Integer) = getCoordinates(coords)[i]


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Get the data type for an `CoordinatesCartesian` object.
"""
Base.eltype(coords::CoordinatesCartesian{T}) where {T} = T


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Helper (unexported) function to help convert from cartesian to any spherical-type coordinate.
If longitude0 is 0, then the interval is [0, 360). Otherwise it is [-180, 180)
"""
function _fromCartesian(coords)
	norm = sqrt(coords[1] ^ 2 + coords[2] ^ 2)
	longitude = atan(coords[2], coords[1])
	latitude = atan(coords[3], norm)
	longitude = rad2deg(longitude)
	latitude = rad2deg(latitude)
	longitude = mod(longitude + 360., 360.)
	return (longitude, latitude)
end

# ----------------------------------------------------------------------------------------------- #
#