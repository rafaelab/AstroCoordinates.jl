# ---------------------------------------------------------------------------------- #
#
@doc """
Abstract type to handle various date/time measurements.
"""
abstract type AbstractTime end


# ---------------------------------------------------------------------------------- #
#
@doc """

"""




# ---------------------------------------------------------------------------------- #
#
@doc """
This macro generate some time standards to automatically generate the corresponding structures.

# Input
. `standardName::AbstractString`: name of the time standard \\
. `info::AbstractString`: information for documentation \\
"""
macro _createTimeStandard(standardName, info)
	name = Symbol("Time$(standardName)")
	quote
		# @doc """
		# (esc(info))
		# """
		struct $(esc(name)) <: AbstractTime
			value::DateTime
			$(esc(name))(dt::DateTime) = new(dt)
		end

		$(esc(name))(d::Date, t::Time) = $(esc(name))(DateTime(d, t))

		$(esc(name))(year::Integer, month::Integer, day::Integer, hour::Integer, minute::Integer, second::Integer, timeArgs...) = $(esc(name))(Date(year, month, day), Time(hour, minute, second, timeArgs...))
	end
end

# ---------------------------------------------------------------------------------- #
#
include("time/julian.jl")
include("time/gst.jl")
include("time/ut1.jl")
include("time/utc.jl")
include("time/lst.jl")
include("time/utilities.jl")
include("time/transformations.jl")
include("time/io.jl")


# ---------------------------------------------------------------------------------- #
