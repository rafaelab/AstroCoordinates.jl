export
	GeoCoordinatesGeocentric


# ---------------------------------------------------------------------------------- #
#
@doc """ 
Geocentric coordinate system plus altitude (with respect to sea level).
It is also known as "geographical" coordinates.
The Earth is assumed to be spherical.
"""
struct GeoCoordinatesGeocentric{A <: Angle, L <: Length} <: AbstractGeoCoordinates
	φ::A
	λ::A
	a::L
	function GeoCoordinatesGeocentric(φ::Angle{U}, λ::Angle{U}, a::Length{U}) where {U}
		return new{typeof(φ), typeof(a)}(φ, λ, a)
	end
end

function GeoCoordinatesGeocentric(φ::Angle{Φ}, λ::Angle{Λ}, a::Length{A}) where {Φ, Λ, A}
	T = promote_type(Φ, Λ, A)
	return GeoCoordinatesGeocentric(T(φ), T(λ), T(a))
end

GeoCoordinatesGeocentric(φ::Angle{Φ}, λ::Angle{Λ})  where {Φ, Λ, A} = GeoCoordinatesGeocentric(promote(φ, λ)..., 0. * u"m")

GeoCoordinatesGeocentric(φ::Real, λ::Real, a::Real) = GeoCoordinatesGeocentric(φ * u"°", λ * u"°", a * u"m")

GeoCoordinatesGeocentric(φ::Real, λ::Real) = GeoCoordinatesGeocentric(φ, λ, 0.)


# ---------------------------------------------------------------------------------- #