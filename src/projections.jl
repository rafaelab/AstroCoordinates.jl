export 
	convertToPlotCoordinates

# ----------------------------------------------------------------------------------------------- #
#
@doc """
Type of skymap projection (e.g. Aitoff, Mollweide, etc).
"""
abstract type AbstractProjection{T} end


# ----------------------------------------------------------------------------------------------- #
#
include("projections/aitoffHammer.jl")


# ----------------------------------------------------------------------------------------------- #