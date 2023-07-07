export
	CoordinatesHorizontal
 

# ---------------------------------------------------------------------------------- #
#
@doc """
Local coordinates with respect to the horizon.
"""
struct CoordinatesHorizontal{T} <: AbstractCoordinatesSky{T}
	φ::Angle{T}
	θ::Angle{T}
	t::TimeLAST{T}
	function CoordinatesHorizontal(φ::Angle{U}, θ::Angle{U}, t::TimeLAST) where {U}
		return new{U}(φ, θ, t)
	end
end

CoordinatesHorizontal(φ::Angle{Φ}, θ::Angle{Θ}, t::TimeLAST) where {Φ, Θ} = CoordinatesHorizontal(promote(φ, θ)..., t)

CoordinatesHorizontal(φ::Angle{Φ}, θ::Angle{Θ}, t::TimeLMST) where {Φ, Θ} = CoordinatesHorizontal(promote(φ, θ)..., TimeLAST(t.value))

CoordinatesHorizontal(φ::Real, θ::Real, t::Union{TimeLMST, TimeLAST}) = CoordinatesHorizontal(φ * u"°", θ * u"°", t)

CoordinatesHorizontal(φ::Real, θ::Real, t::DateTime) = CoordinatesHorizontal(φ * u"°", θ * u"°", TimeLAST(t))

# ---------------------------------------------------------------------------------- #
#
@doc """
Get azimuthal angle.
"""
getAzimuth(coord::CoordinatesHorizontal) = coord.φ


# ---------------------------------------------------------------------------------- #
#
@doc """
Get zenith angle.
"""
getZenith(coord::CoordinatesHorizontal) = coord.θ


# ---------------------------------------------------------------------------------- #
#
@doc """
$(_docs_getLongitude_str)
"""
getLongitude(coord::CoordinatesHorizontal) = coord.φ


# ---------------------------------------------------------------------------------- #
#
@doc """
$(_docs_getLatitude_str)
"""
getLatitude(coord::CoordinatesHorizontal) = 90. * u"°" - coord.θ


# ---------------------------------------------------------------------------------- #