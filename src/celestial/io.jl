# ----------------------------------------------------------------------------------------------- #
#
@doc """
	@show(io, coords)
	print(io, coords)
	println(io, coords)

Display information about objects of type `AbstractCoordinatesSky`

# Input
. `io`: `IO`-type objects with standard output \\
. `coords`: an object of type `AbstractCoordinatesSky`  \\
"""
function Base.show(io::IO, coords::CoordinatesICRS)
	printstyled(io, "ICRS coordinates: "; bold = true)
	coordStr = _getCoordinatesString(coords)
	print(io, " (α, δ) = $coordStr")
end

function Base.show(io::IO, coords::CoordinatesEquatorial)
	printstyled(io, "Equatorial coordinates (J2000): "; bold = true)
	coordStr = _getCoordinatesString(coords)
	print(io, " (α, δ) = $coordStr")
end

function Base.show(io::IO, coords::CoordinatesGalactic)
	printstyled(io, "Galactic coordinates: "; bold = true)
	coordStr = _getCoordinatesString(coords)
	print(io, " (l, b) = $coordStr")
end

function Base.show(io::IO, coords::CoordinatesSuperGalactic)
	printstyled(io, "SuperGalactic coordinates: "; bold = true)
	coordStr = _getCoordinatesString(coords)
	print(io, " (l, b) = $coordStr")
end


# ----------------------------------------------------------------------------------------------- #
#
# Helper function to craete a consistent style for all `AbstractCoordinatesSky`.
function _getCoordinatesString(coords::AbstractCoordinatesSky)
	lat0 = getLatitude(coords) |> u"°"
	lon0 = getLongitude(coords) |> u"°"
	lat = @sprintf("%4.3f°", ustrip(lat0))
	lon = @sprintf("%4.3f°", ustrip(lon0))
	return "($lon, $lat)"
end


# ----------------------------------------------------------------------------------------------- #