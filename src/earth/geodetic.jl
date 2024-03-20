export
	GeoCoordinatesGeodetic

# ----------------------------------------------------------------------------------------------- #
#
@doc """ 
Geodetic coordinate system plus altitude (with respect to sea level).
It is also known as "geographical" coordinates.
The Earth is assumed to 
"""
struct GeoCoordinatesGeodetic{A <: Angle, L <: Length} <: AbstractGeoCoordinates
	φ::A
	λ::A
	a::L
	function GeoCoordinatesGeodetic(φ::Angle{U}, λ::Angle{U}, a::Length{U}) where {U}
		return new{typeof(φ), typeof(a)}(φ, λ, a)
	end
end

function GeoCoordinatesGeodetic(φ::Angle{Φ}, λ::Angle{Λ}, a::Length{A}) where {Φ, Λ, A}
	T = promote_type(Φ, Λ, A)
	return GeoCoordinatesGeodetic(T(φ), T(λ), T(a))
end

GeoCoordinatesGeodetic(φ::Angle{Φ}, λ::Angle{Λ})  where {Φ, Λ} = GeoCoordinatesGeodetic(promote(φ, λ)..., 0. * u"m")

GeoCoordinatesGeodetic(φ::Real, λ::Real, a::Real) = GeoCoordinatesGeodetic(φ * u"°", λ * u"°", a * u"m")

GeoCoordinatesGeodetic(φ::Real, λ::Real) = GeoCoordinatesGeodetic(φ * u"°", λ * u"°", 0. * u"m")


# ----------------------------------------------------------------------------------------------- #