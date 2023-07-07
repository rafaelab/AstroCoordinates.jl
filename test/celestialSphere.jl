using Test
using Unitful

push!(LOAD_PATH, "$(@__DIR__)/../src")
using AstronomicalCoordinates



# ---------------------------------------------------------------------------------- #
#
t1 = TimeUT1(DateTime(1987, 08, 23, 10, 25, 00))
t2 = TimeUT1(DateTime(2022, 07, 06, 14, 57, 00))

@info "==> Earth Rotation Angle"
@testset "Earth Rotation Angle" begin
	# reference values from https://dc.zah.uni-heidelberg.de/apfs/times/q/form
	era1 = 127.591727 * u"°"
	era2 = 148.535999 * u"°"

	t1_jd = convert(TimeJD, t1)
	t2_jd = convert(TimeJD, t2)
	θ1 = getEarthRotationAngle(t1_jd.value) |> u"°"
	θ2 = getEarthRotationAngle(t2_jd.value) |> u"°"

	approxArgs = Dict(:rtol => 1e-4)
	@test isapprox(θ1, era1; approxArgs...)
	@test isapprox(θ2, era2; approxArgs...)
end


# ---------------------------------------------------------------------------------- #