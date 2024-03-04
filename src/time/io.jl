# ----------------------------------------------------------------------------------------------- #
#
@doc """
	@show(io, t)
	print(io, t)
	println(io, t)

Display information about objects of type `AbstractTime`.

# Input
. `io`: `IO`-type objects with standard output \\
. `t`: an object of type `AbstractTime` \\
"""
function Base.show(io::IO, t::TimeJD)
	printstyled(io, "Julian date: "; bold = true)
	print(io, " JD = $(t.value)")
end

function Base.show(io::IO, t::TimeMJD)
	printstyled(io, "Modified Julian date: "; bold = true)
	print(io, " MJD = $(t.value)")
end

function Base.show(io::IO, t::TimeStandards)
	printstyled(io, "$(typeof(t)): "; bold = true)
	print(io, " t = $(t.value)")
end

# ----------------------------------------------------------------------------------------------- #