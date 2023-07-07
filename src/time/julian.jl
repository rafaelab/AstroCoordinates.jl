export 
	TimeJD,
	TimeMJD

# ---------------------------------------------------------------------------------- #
#
@doc """
Definition of Julian's zero.
"""
const jd_0 = 0.
const dt_jd_0 = DateTime(-4713, 1, 1, 12, 0, 0)
	
# ---------------------------------------------------------------------------------- #
#
@doc """
Julian day starting at noon (UT1) in January 1st, 2000.
"""
const jd_2000 = 2451545.0
const dt_jd_2000 = DateTime(2000, 1, 1, 12, 0, 0)

# ---------------------------------------------------------------------------------- #
#
@doc """
The Julian calendar is the time ellapsed since year 1 of the Julian Period was 4713 BC (−4712).
The Julian day number (JDN) is the number of days using noon of UT1 as a threshold.
"""
struct TimeJD{T <: Real} <: AbstractTime
	value::T
	function TimeJD(t::Real)
		U = promote_type(typeof(t), Float64)
		return new{U}(t)
	end
end

# ---------------------------------------------------------------------------------- #
#
@doc """
Reference date for MJD.
"""
const mjd_0 = 2400000.5 
const dt_mjd_0 = DateTime(1858, 11, 17, 0, 0, 0)

# ---------------------------------------------------------------------------------- #
#
@doc """
The modified Julian date (MJD) aims at simplifying calculations. 
It starts at midnight of November 17 1858.
It is calculated as: MJD = JD - 2400000.5 
"""
struct TimeMJD{T <: Real} <: AbstractTime
	value::T
	function TimeMJD(t::Real)
		U = promote_type(typeof(t), Float64)
		return new{U}(t)
	end
end

# ---------------------------------------------------------------------------------- #