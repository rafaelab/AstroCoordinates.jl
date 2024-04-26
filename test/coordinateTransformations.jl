using Test

push!(LOAD_PATH, normpath("$(@__DIR__)/../src"))
using AstroCoordinates



# ---------------------------------------------------------------------------------- #
#
# Comparisons below are with respect to AstroPy.
# ```
# v1 = SkyCoord(ra = 10.00 * u.degree, dec =  30.0 * u.degree, frame = 'icrs')
# v2 = SkyCoord(ra = 179.0 * u.degree, dec = -89.0 * u.degree, frame = 'icrs')
# v3 = SkyCoord(l = 45.0 * u.degree, b = -12.0 * u.degree, frame = 'galactic')
# ```
# The calculation is implemented in the script `coordinatesTransformations.py`.
@info "coordinate transformations"
@testset "conversions" begin
	coordICRS1_ref = CoordinatesICRS(10., 30.)
	coordICRS2_ref = CoordinatesICRS(179., -89.)
	coordGal1_ref = CoordinatesGalactic(45., -12.)

	@testset "ICRS => equatorial" begin
		coordEq1 = convert(CoordinatesEquatorial, coordICRS1_ref)
		coordEq2 = convert(CoordinatesEquatorial, coordICRS2_ref)

		approxArgs = Dict(:rtol => 1e-5)
		@test isapprox(ustrip(getLongitude(coordEq1)), 10.00000976; approxArgs...)
		@test isapprox(ustrip(getLatitude(coordEq1)), 30.00000153; approxArgs...)
		@test isapprox(ustrip(getLongitude(coordEq2)), 179.00032047; approxArgs...)
		@test isapprox(ustrip(getLatitude(coordEq2)), -89.00000262; approxArgs...)
	end

	@testset "ICRS => galactic" begin
		coordGal1 = convert(CoordinatesGalactic, coordICRS1_ref)
		coordGal2 = convert(CoordinatesGalactic, coordICRS2_ref)

		approxArgs = Dict(:rtol => 1e-5)
		@test isapprox(ustrip(getLongitude(coordGal1)), 119.98555603; approxArgs...)
		@test isapprox(ustrip(getLatitude(coordGal1)), -32.80630443; approxArgs...)
		@test isapprox(ustrip(getLongitude(coordGal2)), 302.66506563; approxArgs...)
		@test isapprox(ustrip(getLatitude(coordGal2)), -26.15711471; approxArgs...)
	end

	@testset "ICRS => supergalactic" begin
		coordSG1 = convert(CoordinatesSuperGalactic, coordICRS1_ref)
		coordSG2 = convert(CoordinatesSuperGalactic, coordICRS2_ref)

		approxArgs = Dict(:rtol => 1e-5)
		@test isapprox(ustrip(getLongitude(coordSG1)), 324.78458023; approxArgs...)
		@test isapprox(ustrip(getLatitude(coordSG1)), 10.95043796; approxArgs...)
		@test isapprox(ustrip(getLongitude(coordSG2)), 205.44452827; approxArgs...)
		@test isapprox(ustrip(getLatitude(coordSG2)), -15.96129158; approxArgs...)
	end

	@testset "galactic => supergalactic" begin
		coordSG = convert(CoordinatesSuperGalactic, coordGal1_ref)

		approxArgs = Dict(:rtol => 1e-5)
		@test isapprox(ustrip(getLongitude(coordSG)), 262.66504959; approxArgs...)
		@test isapprox(ustrip(getLatitude(coordSG)), 71.52901373; approxArgs...)
	end

	@testset "galactic => equatorial" begin
		coordEq = convert(CoordinatesEquatorial, coordGal1_ref)
		
		approxArgs = Dict(:rtol => 1e-5)
		@test isapprox(ustrip(getLongitude(coordEq)), 299.08113997; approxArgs...)
		@test isapprox(ustrip(getLatitude(coordEq)), 5.00270085; approxArgs...)
	end


	@testset "icrs => horizontal" begin
		location = GeoCoordinatesGeocentric(10., 50.)
		utc = DateTime(1987, 8, 23, 09, 25, 00)
		time = TimeLAST(utc, location)

		# coordHz = convert(CoordinatesHorizontal, convert(CoordinatesEquatorial, coordICRS1_ref), time, location)
		
		# approxArgs = Dict(:rtol => 1e-5)
		# @test isapprox(ustrip(getAzimuth(coordHz)), 305.71170612; approxArgs...)
		# @test isapprox(ustrip(getZenith(coordHz)), -9.70615544; approxArgs...)
	end

end



# ---------------------------------------------------------------------------------- #