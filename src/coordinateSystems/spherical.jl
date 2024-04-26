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
For performance, no units are stored in the structure. 
Angles are internally stored in degrees and the radius in meters.
When they are explicitly called from the object, they are returned with units.
"""
struct CoordinatesSpherical{T}
	coordinates::SVector{3, T}
	function CoordinatesSpherical(v::SVector{3, T}) where {T}
		return new{T}(v)
	end
end

CoordinatesSpherical(coords::Vector) = CoordinatesSpherical(SVector{eltype(coords)}(coords))

CoordinatesSpherical(r::R, φ::Φ, θ::Θ) where {R <: Real, Φ <: Real, Θ <: Real} = CoordinatesSpherical(SVector{3, promote_type(R, Φ, Θ)}(r, φ, θ))

CoordinatesSpherical(r::R, φ::Φ, θ::Θ) where {R <: Real, Φ <: Angle, Θ <: Angle} = CoordinatesSpherical(r, ustrip(φ |> u"°"), ustrip(θ |> u"°"))

CoordinatesSpherical(r::R, φ::Φ, θ::Θ) where {R <: Length, Φ <: Angle, Θ <: Angle} = CoordinatesSpherical(ustrip(r |> u"m"), ustrip(φ |> u"°"), ustrip(θ |> u"°"))

CoordinatesSpherical(coords::Tuple{R, Φ, Θ}) where {R, Φ, Θ} = CoordinatesSpherical(coords...)


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
Get the coordinates by name for a given `CoordinatesSpherical`.
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