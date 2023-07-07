export 
	TimeLMST,
	TimeLAST


# ---------------------------------------------------------------------------------- #
#
abstract type TimeLST <: AbstractTime end	

# ---------------------------------------------------------------------------------- #
#
@doc """
The local sidereal time (LST) is based on the Earth's rotation with respect to the fixed stars.
This essentially corresponds to taking the sideral day: 23 h 56 min 4.0905s.
This conversion takes into account nutation, so it is based on timeGAST.
"""
struct TimeLMST{G <: AbstractGeoCoordinates} <: TimeLST
	value::DateTime
	location::G
	function TimeLMST(time::DateTime, location::L) where {L <: AbstractGeoCoordinates}
		return new{L}(time, location)
	end
end

TimeLMST(date::Date, time::Time, location::AbstractGeoCoordinates) = TimeLMST(DateTime(date, time), location)
TimeLMST(location::AbstractGeoCoordinates, date::Date, time::Time) = TimeLMST(DateTime(date, time), location)

TimeLMST(location::AbstractGeoCoordinates, year::Integer, month::Integer, day::Integer, hour::Integer, minute::Integer, second::Integer, timeArgs...) = TimeLMST(Date(year, month, day), Time(hour, minute, second, timeArgs...), location)



# ---------------------------------------------------------------------------------- #
#
@doc """
The local sidereal time (LST) is based on the Earth's rotation with respect to the fixed stars.
This essentially corresponds to taking the sideral day: 23 h 56 min 4.0905s.
This conversion takes into account nutation, so it is based on timeGAST.
"""
struct TimeLAST{G <: AbstractGeoCoordinates} <: TimeLST
	value::DateTime
	location::G
	function TimeLAST(time::DateTime, location::L) where {L <: AbstractGeoCoordinates}
		return new{L}(time, location)
	end
end

TimeLAST(date::Date, time::Time, location::AbstractGeoCoordinates) = TimeLAST(DateTime(date, time), location)
TimeLAST(location::AbstractGeoCoordinates, date::Date, time::Time) = TimeLAST(DateTime(date, time), location)

TimeLAST(location::AbstractGeoCoordinates, year::Integer, month::Integer, day::Integer, hour::Integer, minute::Integer, second::Integer, timeArgs...) = TimeLAST(Date(year, month, day), Time(hour, minute, second, timeArgs...), location)


# ---------------------------------------------------------------------------------- #