export 
	TimeGMST,
	TimeGAST


# ----------------------------------------------------------------------------------------------- #
#
@doc """
"""
abstract type TimeGST <: AbstractTime end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This time standard is essentially the right ascension directly above the Greenwich meridian at a given time.
"""
struct TimeGMST <: TimeGST
	value::DateTime
	TimeGMST(dt::DateTime) = new(dt)
end

TimeGMST(d::Date, t::Time) = TimeGMST(DateTime(d, t))

TimeGMST(year::Integer, month::Integer, day::Integer, hour::Integer, minute::Integer, second::Integer, timeArgs...) = TimeGMST(Date(year, month, day), Time(hour, minute, second, timeArgs...))


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Greenwich apparent sidereal time (GAST).
This is the same as GMST but corrected for the vernal equinox due to nutation.
"""
struct TimeGAST <: TimeGST
	value::DateTime
	TimeGAST(dt::DateTime) = new(dt)
end

TimeGAST(d::Date, t::Time) = TimeGAST(DateTime(d, t))

TimeGAST(year::Integer, month::Integer, day::Integer, hour::Integer, minute::Integer, second::Integer, timeArgs...) = TimeGAST(Date(year, month, day), Time(hour, minute, second, timeArgs...))


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Helper function (unexported) to convert JD to GMST.

# Reference (eq. 2.12)
	"The IAU Resolutions on Astronomical Reference Systems, Time Scales, and Earth Rotation Models"
	G. H. Kaplan
	US Naval Observatory Circular #179
	astro-ph/0602086
	https://aa.usno.navy.mil/downloads/Circular_179.pdf

# Output
. GMST time in canonical `Time` format
"""
function _jd2gmst(jd::Real; referenceJD::Real = jd_2000)
	t = getNumberOfJulianCenturies(jd; referenceJD = referenceJD)
	θ = (getEarthRotationAngle(t) |> u"rad") / 2π
	coeff = [0.014506, 4612.156534, 1.3915817, -0.00000044, -0.000029956, -0.0000000368] / 15.
	δθ = evaluatePolynomialOfT(jd, coeff; referenceJD = referenceJD) * u"arcsecond" |> u"rad"

	gmst =  86400. * θ + δθ 
	if gmst < 0.
		gmst += 2π * u"rad"
	end

	gmst = mod(gmst, 2π * u"rad")
	gmst = ustrip(gmst) * 13750.9871

	return gmst * u"s"
end


# ----------------------------------------------------------------------------------------------- #
#
 @doc """
Helper function (unexported) to convert GMT to GAST.

# Reference (eq. 2.13)
	"The IAU Resolutions on Astronomical Reference Systems, Time Scales, and Earth Rotation Models"
	G. H. Kaplan
	US Naval Observatory Circular #179
	astro-ph/0602086
	https://aa.usno.navy.mil/downloads/Circular_179.pdf

# Output
. GAST time in seconds
"""
function _jd2gast(jd::Real; referenceJD::Real = jd_2000)
	gmst = _jd2gmst(jd; referenceJD = referenceJD)
	E_Υ = ustrip(computeEquinox(jd; referenceJD = referenceJD) / 15.) * u"s"
	return (gmst +  E_Υ)
end

# ----------------------------------------------------------------------------------------------- #