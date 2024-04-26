# ----------------------------------------------------------------------------------------------- #
#
@doc """
	@show(io, coords)
	print(io, coords)
	println(io, coords)

Display information about objects of type `CoordinatesCartesian` or `CoordinateSpherical`.

# Input
. `io`: `IO`-type objects with standard output \\
. `coords`: an object of type `CoordinatesCartesian` or `CoordinateSpherical` \\
"""
function Base.show(io::IO, coords::CoordinatesCartesian)
	printstyled(io, "Cartesian coordinates: "; bold = true)
	x = @sprintf("%5.4f", coords.x)
	y = @sprintf("%5.4f", coords.y)
	z = @sprintf("%5.4f", coords.z)
	print(io, " (x, y, z) = ($x, $y, $z)")
end

function Base.show(io::IO, coords::CoordinatesSpherical)
	printstyled(io, "Spherical coordinates: "; bold = true)
	r = "$(coords.r)"
	φ = "$(coords.φ)"
	θ = "$(coords.θ)"
	print(io, " (r, φ, θ) = ($r, $φ, $θ)")
end

function Base.show(io::IO, coords::CoordinatesSphericalAngular)
	printstyled(io, "Spherical coordinates on unit sphere: "; bold = true)
	φ = "$(coords.φ)"
	θ = "$(coords.θ)"
	print(io, " (φ, θ) = ($φ, $θ)")
end


# ----------------------------------------------------------------------------------------------- #