export angularDistance


# # ----------------------------------------------------------------------------------------------- #
# #
# _coordNameDict = Dict()
# _coordNameDict[CoordinatesICRS] = (:α, :δ)
# _coordNameDict[CoordinatesEquatorial] = (:α, :δ)
# _coordNameDict[CoordinatesGalactic] = (:l, :b)
# _coordNameDict[CoordinatesSuperGalactic] = (:l, :b)
# _coordNameDict[CoordinatesHorizontal] = (:φ, :θ)

# # ----------------------------------------------------------------------------------------------- #
# #
# for coordSysName ∈ ("ICRS", "Equatorial", "Galactic", "SuperGalactic", "Horizontal")
# 	coordSys = Symbol("Coordinates$(coordSysName)")
# 	@eval begin
# 		function Base.:(+)(u::$(coordSys), v::$(coordSys))
# 			lonVar, latVar = _coordNameDict[$(coordSys)]
# 			u_lon, u_lat = getfield(u, lonVar), getfield(u, latVar)
# 			v_lon, v_lat = getfield(v, lonVar), getfield(v, latVar)
# 			lon = mod((u_lon |> u"°") + (v_lon |> u"°"), 360. * u"°")
# 			# lat = mod((u_lat |> u"°") + (v_lat |> u"°"), 180. * u"°") - 90. * u"°"
# 			lat = (u_lat |> u"°") + (v_lat |> u"°")
# 			if lat > 90. * u"°"
# 			return $(coordSys)(lon, lat)
# 		end

# 		function Base.:(-)(u::$(coordSys), v::$(coordSys))
# 			lonVar, latVar = _coordNameDict[$(coordSys)]
# 			u_lon, u_lat = getfield(u, lonVar), getfield(u, latVar)
# 			v_lon, v_lat = getfield(v, lonVar), getfield(v, latVar)
# 			lon = mod((u_lon |> u"°") - (v_lon |> u"°"), 360. * u"°")
# 			lat = mod((u_lat |> u"°") - (v_lat |> u"°"), 180. * u"°") 
# 			if lat < 0. * u"°"
# 				lat += - 90. * u"°"
# 			return $(coordSys)(lon, lat)
# 		end
# 	end
# end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Distance between two points on the sphere.
"""
function angularDistance(coord1::AbstractCoordinatesSky, coord2::AbstractCoordinatesSky)
	coordCart1 = convert(CoordinatesCartesian, coord1)
	coordCart2 = convert(CoordinatesCartesian, coord2)
	angle = acos(dot(coordCart1.coordinates, coordCart2.coordinates)) * u"rad"
	return angle |> u"°"
end


# ----------------------------------------------------------------------------------------------- #