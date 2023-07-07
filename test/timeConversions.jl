using Test

push!(LOAD_PATH, "$(@__DIR__)/../src")
using AstronomicalCoordinates



# ---------------------------------------------------------------------------------- #
#
# Comparisons below are with respect to AstroPy.
# ```
# 
# ```
@info "==> Time conversions"

t1 = TimeUTC(DateTime(2010, 01, 01, 00, 00, 00))
t2 = TimeUT1(DateTime(1987, 08, 23, 10, 25, 00))
t3 = TimeJD(2455197.5)
t4 = TimeMJD(47030.434)
t5 = TimeGMST(DateTime(1987, 08, 23, 10, 25, 00))
t6 = TimeGAST(DateTime(1987, 08, 23, 10, 25, 00))

# testName = "UTC, UT1 => JD, MJD"
# @info "$(testName)"
# @testset "$(testName)" begin
# 	t1_jd = convert(TimeJD, t1)
# 	t1_mjd = convert(TimeMJD, t1)
# 	t2_jd = convert(TimeJD, t2)
# 	t2_mjd = convert(TimeMJD, t2)
# 	@test t1_jd.value == 2455197.5
# 	@test t1_mjd.value == 55197.0
# 	@test t2_jd.value ≈ 2447030.93
# 	@test t2_mjd.value ≈ 47030.434
# end

# testName = " UT1 <=> UTC"
# @info "$(testName)"
# @testset "$(testName)" begin
# 	t1_ut1 = convert(TimeUT1, t1)
# 	t2_utc = convert(TimeUTC, t2)
# 	ut1 = DateTime(2010, 1, 1, 0, 0, 0, 114)
# 	utc = DateTime(1987, 08, 23, 10, 24, 59, 570) # astropy is 569 ms
# 	@test t1_ut1.value == ut1
# 	@test t2_utc.value == utc
# end

# testName = "JD <=> MJD"
# @info "$(testName)"
# @testset "$(testName)" begin
	t3_mjd = convert(TimeMJD, t3)
	t4_jd = convert(TimeJD, t4)
	@test t3_mjd.value == t3.value - AstronomicalCoordinates.mjd_0
	@test t4_jd.value == t4.value + AstronomicalCoordinates.mjd_0
# end

testName = "JD, MJD => GMST, GAST"
@info "$(testName)"
@testset "$(testName)" begin

	# t3_gast = convert(TimeGAST, t3)
	# t3_gmst = convert(TimeGMST, t3)
	# t4_gast = convert(TimeGAST, t4)
	t4_gmst = convert(TimeGMST, t4)
	
	# gast3 = DateTime(2010, 01, 01, 06, 42, 10, 150)
	# gast4 = DateTime(1987, 08, 23, 08, 29, 43, 587)
	gmst3 = DateTime(2010, 01, 01, 06, 42, 09, 144)
	gmst4 = DateTime(1987, 08, 23, 08, 29, 43, 584)

	# @show(t3_gmst.value)
	# @show(gmst3)
	@show(t4_gmst.value)
	@show(gmst4)
	# @show(t4_gast.value)
	# @show(gast4)

	# @test t3_gmst.value == gmst3
	# @test t3_gast.value == gast3
	# @test t4_gmst.value == gmst4
	# @test t4_gast.value == gast4
	
end

# testName = "GMST/GAST <=> LMST/LAST"
# @info "$(testName)"
# @testset "$(testName)" begin
# 	location = GeoCoordinatesGeocentric(50. * u"°", 10. * u"°")

# 	t5_lmst = convert(TimeLMST, t5, location)
# 	t6_last = convert(TimeLAST, t6, location)

# 	lmst5 = DateTime(1987, 08, 23, 8, 29, 46, 416)
# 	last6 = DateTime(1987, 08, 23, 8, 29, 46, 419)

# 	@test t5_lmst.value == lmst5
# 	@test t6_last.value == last6
	
# end



# ---------------------------------------------------------------------------------- #