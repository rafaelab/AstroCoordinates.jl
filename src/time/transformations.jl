# ----------------------------------------------------------------------------------------------- #
#
function Base.convert(::Type{TimeJD}, t::TimeMJD)
	return TimeJD(t.value + mjd_0)
end

function Base.convert(::Type{TimeJD}, t::TimeUTC) 
	return TimeJD(datetime2julian(t.value))
end

function Base.convert(::Type{TimeJD}, t::TimeUT1)
	return convert(TimeJD, convert(TimeUTC, t))
end

function Base.convert(::Type{TimeJD}, t::TimeGMST)
	jd0 = convert(TimeJD, TimeUT1(t.value)).value
	xmin = getNumberOfJulianCenturies(jd0 - 1)
	xmax = getNumberOfJulianCenturies(jd0 + 1)
	jd = find_zero(t -> ustrip(_jd2gmst(t)), (xmin, xmax)) * 36525 + jd_2000
	return TimeJD(jd)
end

function Base.convert(::Type{TimeJD}, t::TimeGAST)
	jd0 = convert(TimeJD, TimeUT1(t.value)).value
	xmin = getNumberOfJulianCenturies(jd0 - 1; referenceJD = jd_2000)
	xmax = getNumberOfJulianCenturies(jd0 + 1; referenceJD = jd_2000)
	jd = find_zero(_jd2gast, (xmin, xmax)) * 36525 + _jd_2000
	return TimeJD(jd)
end

function Base.convert(::Type{TimeMJD}, t::TimeJD)
	return TimeMJD(t.value - mjd_0)
end

function Base.convert(::Type{TimeMJD}, t::TimeStandards)
	jd = convert(TimeJD, t)
	return TimeMJD(jd.value - mjd_0)
end

function Base.convert(::Type{TimeUT1}, t::TimeJD) 
	utc = convert(TimeUTC, t)
	return convert(TimeUT1, utc)
end

function Base.convert(::Type{TimeUT1}, t::TimeMJD) 
	return convert(TimeUT1, convert(TimeJD, t))
end

function Base.convert(::Type{TimeUT1}, t::TimeUTC)
	loadTableDUT1()
	dut1 = computeDUT1(t)
	ut1 = t.value + dut1
	return TimeUT1(ut1)
end

function Base.convert(::Type{TimeUT1}, t::TimeGST)
	jd = convert(TimeJD, t)
	return convert(TimeUT1, jd)
end

function Base.convert(::Type{TimeUTC}, t::TimeJD) 
	return TimeUTC(julian2datetime(t.value))
end

function Base.convert(::Type{TimeUTC}, t::TimeMJD) 
	return convert(TimeUTC, convert(TimeJD, t))
end

function Base.convert(::Type{TimeUTC}, t::TimeUT1)
	loadTableDUT1()
	dut1 = computeDUT1(TimeUTC(t.value))
	utc = t.value + dut1
	return TimeUTC(utc)
end

function Base.convert(::Type{TimeUTC}, t::TimeGST)
	jd = convert(TimeJD, t)
	return convert(TimeUTC, jd)
end

function Base.convert(::Type{TimeGMST}, t::TimeUT1)
	dt = DateTime(Date(t.value))
	jd = convert(TimeJD, t)

	gmst = _jd2gmst(jd.value)
	gmst = convert(CompoundPeriod, gmst) 
	dt += gmst

	return TimeGMST(dt)
end

function Base.convert(::Type{TimeGMST}, t::Union{TimeUTC, TimeGAST})
	ut1 = convert(TimeUT1, t)
	return convert(TimeGMST, ut1)
end

function Base.convert(::Type{TimeGMST}, t::TimeJD)
	return convert(TimeGMST, convert(TimeUT1, t))
end

function Base.convert(::Type{TimeGMST}, t::TimeMJD) 
	jd = convert(TimeJD, t)
	return convert(TimeGMST, jd)
end



function Base.convert(::Type{TimeGAST}, t::TimeGMST)
	jd = convert(TimeJD, t)
	E_Υ = computeEquinox(jd.value) |> u"°"
	E_Υ = ustrip(E_Υ) / 3600. * u"s"
	E_Υ = convert(CompoundPeriod, E_Υ)
	dt = t.value + E_Υ
	return TimeGAST(dt)
end

function Base.convert(::Type{TimeGAST}, t::Union{TimeUT1, TimeUTC, TimeJD, TimeMJD})
	return convert(TimeGAST, convert(TimeGMST, t))
end

function Base.convert(::Type{TimeLMST}, t::TimeGMST, l::AbstractGeoCoordinates)
	λ, φ = getLatitude(l), getLongitude(l)
	# 	λ = getLongitude(l) + (xp * sin(λg) + yp * cos(λg) * tan(φg)) / 3600.
	lmst = t.value + canonicalize(Second(3600. / 15. * ustrip(λ |> u"°")))
	return TimeLMST(lmst, l)
end

function Base.convert(::Type{TimeLMST}, t::Union{TimeUTC, TimeUT1, TimeJD, TimeMJD, TimeLAST, TimeGAST}, l::AbstractGeoCoordinates)
	return convert(TimeLMST, convert(TimeGMST, t), l)
end

function Base.convert(::Type{TimeLAST}, t::TimeGAST, l::AbstractGeoCoordinates)
	λ, φ = getLatitude(l), getLongitude(l)
	# 	λ = getLongitude(l) + (xp * sin(λg) + yp * cos(λg) * tan(φg)) / 3600.
	last = t.value + canonicalize(Second(3600. / 15. * ustrip(λ |> u"°")))
	return TimeLAST(last, l)
end

function Base.convert(::Type{TimeLAST}, t::Union{TimeUTC, TimeUT1, TimeJD, TimeMJD, TimeGAST, TimeGMST}, l::AbstractGeoCoordinates)
	return convert(TimeLAST, convert(TimeGAST, t), l)
end

# function Base.convert(::Type{TimeLAST}, t::TimeGAST, l::AbstractGeoCoordinates)
# 	if l ≠ 

# function Base.convert(::Type{T}, t::TimeMJD) where {T <: Union{TimeUT1, TimeUTC, TimeGMST, TimeGAST}}
# 	return convert(T, convert(TimeJD, t))
# end


# ----------------------------------------------------------------------------------------------- #