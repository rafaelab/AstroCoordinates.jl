# ----------------------------------------------------------------------------------------------- #
#
# List of types that are templated.
const TimeStandards = Union{TimeUT1, TimeUTC, TimeGMST, TimeGAST, TimeLMST, TimeLAST}

# ----------------------------------------------------------------------------------------------- #
#
@doc """
Generic methods for some specific types of time standards.
"""
Dates.Date(dt::TimeStandards) = Date(dt.value)
Dates.Time(dt::TimeStandards) = Time(dt.value)
Dates.DateTime(dt::TimeStandards) = DateTime(Date(dt), Time(dt))

# ----------------------------------------------------------------------------------------------- #
#
@doc """
Number of Julian centuries.
"""
getNumberOfJulianCenturies(jd::Real; referenceJD::Real = jd_2000) = (jd - referenceJD) / 36525.


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Read the table of DUT1 = UT1 - UTC.
Downloaded from:
	https://www.iers.org/IERS/EN/DataProducts/EarthOrientationData/eop.html

# Reference
	International Earth Rotation and Reference Systems Service
"""
mutable struct TableDUT1
	mjd::Vector{Int64}
	dut1::Vector{Float64}
	xp::Vector{Float64}
	yp::Vector{Float64}
end
Base.length(table::TableDUT1) = length(table.mjd)
Base.getindex(table::TableDUT1, i::Integer) = [table.mjd[i], table.dut1[i], table.xp[i], table.yp[i]]
Base.first(table::TableDUT1) = getindex(table, 1)
Base.last(table::TableDUT1) = getindex(table, length(table))

const _tableDUT1 = TableDUT1(Int64[], Float64[], Float64[], Float64[])

function loadTableDUT1()
	if length(_tableDUT1) == 0
		filename = "$(@__DIR__)/../../data/eopc04_14_IAU2000.62-now.csv"
		columns = [1, 6, 8, 11]
		f = CSV.File(filename; delim = ';', select = columns)
		_tableDUT1.mjd = f["MJD"]
		_tableDUT1.dut1 = f["UT1-UTC"]
		_tableDUT1.xp = f["x_pole"]
		_tableDUT1.yp = f["y_pole"]
	end
end

@doc """
Auxiliary function to check if a value is in the tabulated DUT1 range.
"""
function _isInRange(t1::TimeMJD)
	if t1.value ≥ first(_tableDUT1.mjd) && t1.value ≤ last(_tableDUT1.mjd)
		return true
	end
	return false
end


@doc """
Compute the DUT1 values at given MJD/UTC date.
"""
function computeDUT1(t::TimeMJD)
	loadTableDUT1()
	if ! _isInRange(t)
		println("Table with DUT1 is only available from $(first(_tableDUT1.mjd)) to $(last(_tableDUT1.mjd)).\nI will return 0.")
		return 0.
	end

	dut1 = _tableDUT1.dut1[searchsortedlast(_tableDUT1.mjd, t.value)]
	dut1 = convert(CompoundPeriod, dut1 * u"s")

	return dut1
end

computeDUT1(t::TimeUTC) = computeDUT1(convert(TimeMJD, t))


# ---------------------------------------------------------------------------------- #