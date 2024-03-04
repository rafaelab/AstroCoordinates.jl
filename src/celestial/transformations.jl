
# ----------------------------------------------------------------------------------------------- #
#
@doc """
Overload Julia's base function `convert`.
Convert from an object of type `AbstractCoordinatesSky` to cartesian coordinates (`CoordinatesCartesian`).
"""
function Base.convert(::Type{CoordinatesCartesian}, coords::AbstractCoordinatesSky) 
	x = cos(getLatitude(coords)) * cos(getLongitude(coords))
	y = cos(getLatitude(coords)) * sin(getLongitude(coords))
	z = sin(getLatitude(coords))
	return  CoordinatesCartesian(x, y, z)
end


# ----------------------------------------------------------------------------------------------- #
#
# @doc """
# Overload Julia's base function `convert`.
# Convert from an object of type `CoordinatesCartesian` to `AbstractCoordinatesSky` .
# """
for coordSyss ∈ ("ICRS", "Equatorial", "Galactic", "SuperGalactic")
	coordSys = Symbol("Coordinates$(coordSyss)")
	@eval begin
		Base.convert(::Type{$(coordSys)}, coords::CoordinatesCartesian) = $(coordSys)(_fromCartesian(coords)...)
	end
end

function Base.convert(::Type{CoordinatesHorizontal}, coords::CoordinatesCartesian, time::TimeLST, location::AbstractGeoCoordinates)
end


# ----------------------------------------------------------------------------------------------- #
#


###
Base.convert(::Type{CoordinatesEquatorial}, coords::CoordinatesEquatorial) = coords

function Base.convert(::Type{CoordinatesEquatorial}, coords::CoordinatesICRS)
	R = RotXYZ(η0, -ξ0, -dα0)
	xyz = convert(CoordinatesCartesian, coords)
	return convert(CoordinatesEquatorial, CoordinatesCartesian(R * xyz.coordinates))
end

function Base.convert(::Type{CoordinatesEquatorial}, coords::CoordinatesGalactic)
	R = RotZYZ(l_NCP - 180. * u"°",  δ_NGP - 90. * u"°", - α_NGP)'
	xyz = convert(CoordinatesCartesian, coords)
	return convert(CoordinatesEquatorial, CoordinatesCartesian(R * xyz.coordinates))
end

function Base.convert(::Type{CoordinatesEquatorial}, coords::CoordinatesSuperGalactic)
	coordsGal = convert(CoordinatesGalactic, coords)
	return convert(CoordinatesEquatorial, coordsGal)
end

function Base.convert(::Type{CoordinatesHorizontal}, coords::CoordinatesEquatorial, time::TimeLST, location::AbstractGeoCoordinates)
	# # φθ
	# tanφ = sin(h)
	φo = getLongitude(location)
	λo = getLatitude(location)
	lst = convert(typeof(1. * u"°"), Time(time.value))

	Ry = RotY(90. * u"°" - φo)'
	Rz = SMatrix{3, 3}(cos(lst), sin(lst), 0., sin(lst), -cos(lst), 0., 0., 0., 1.)
	R = Ry * Rz

	xyz_eq = convert(CoordinatesCartesian, coords)
	xyz_hz = CoordinatesCartesian(R * xyz_eq.coordinates)

	return CoordinatesHorizontal(xyz_hz)
end


###
Base.convert(::Type{CoordinatesICRS}, coords::CoordinatesICRS) = coords

function Base.convert(::Type{CoordinatesICRS}, coords::CoordinatesEquatorial)
	R = RotXYZ(η0, -ξ0, -dα0)'
	xyz = convert(CoordinatesCartesian, coords)
	return convert(CoordinatesICRS, CoordinatesCartesian(R * xyz.coordinates))
end

function Base.convert(::Type{CoordinatesICRS}, coords::CoordinatesGalactic)
	coordsEq = convert(CoordinatesEquatorial, coords)
	return convert(CoordinatesICRS, coordsEq)
end

function Base.convert(::Type{CoordinatesICRS}, coords::CoordinatesSuperGalactic)
	coordsGal = convert(CoordinatesGalactic, coords)
	return convert(CoordinatesICRS, coordsGal)
end

###
Base.convert(::Type{CoordinatesGalactic}, coords::CoordinatesGalactic) = coords

function Base.convert(::Type{CoordinatesGalactic}, coords::CoordinatesEquatorial)
	R = RotZYZ(l_NCP - 180. * u"°",  δ_NGP - 90. * u"°", - α_NGP)
	xyz = convert(CoordinatesCartesian, coords)
	return convert(CoordinatesGalactic, CoordinatesCartesian(R * xyz.coordinates))
end

function Base.convert(::Type{CoordinatesGalactic}, coords::CoordinatesICRS)
	coordsEq = convert(CoordinatesEquatorial, coords)
	return convert(CoordinatesGalactic, coordsEq)
end

function Base.convert(::Type{CoordinatesGalactic}, coords::CoordinatesSuperGalactic)
	R = matrixSuperGalactic2Galactic
	xyz = convert(CoordinatesCartesian, coords)
	coordsGal = convert(CoordinatesGalactic, CoordinatesCartesian(R * xyz.coordinates))
	return coordsGal 
end


### 
Base.convert(::Type{CoordinatesSuperGalactic}, coords::CoordinatesSuperGalactic) = coords

function Base.convert(::Type{CoordinatesSuperGalactic}, coords::CoordinatesGalactic)
	R = matrixSuperGalactic2Galactic'
	xyz = convert(CoordinatesCartesian, coords)
	coordsSGal = convert(CoordinatesSuperGalactic, CoordinatesCartesian(R * xyz.coordinates))
	return coordsSGal 
end

function Base.convert(::Type{CoordinatesSuperGalactic}, coords::CoordinatesICRS)
	coordsGal = convert(CoordinatesGalactic, coords)
	return convert(CoordinatesSuperGalactic, coordsGal)
end

function Base.convert(::Type{CoordinatesSuperGalactic}, coords::CoordinatesEquatorial)
	coordsGalactic = convert(CoordinatesGalactic, coords)
	return convert(CoordinatesSuperGalactic, coordsGal)
end


# ----------------------------------------------------------------------------------------------- #
#