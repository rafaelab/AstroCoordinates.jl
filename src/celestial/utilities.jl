export
	computeHourAngle



# ----------------------------------------------------------------------------------------------- #
#
@doc """
Angle between the Earth's axis and the zenith.
If time is `Real`, then it is assumed to be in degrees.
The right ascension `α` is assumed to be given in degrees

# Input
. `time::Union{TimeLSMT, TimeLAST, Real}`: the local sidereal time \\
. `α::Union{Angle, Real}`: the right ascension of the object of interest. \\

# Output
. Object of type `Time` (from `Dates.jl`)
"""
computeHourAngle(lst::Union{TimeLMST, TimeLAST}, α::Angle) = Time(lst.value) - uconvert(Time, α |> u"hourAngle")
computeHourAngle(lst::Real, α::Real) = computeHourAngle(lst * u"°", α * u"°")
computeHourAngle(lst::Unitful.Time, α::Α) where {Α <: Union{Real, <: Angle}} = computeHourAngle(convert(CompoundPeriod, Time(lst.value)), α * u"°") 


# ----------------------------------------------------------------------------------------------- #