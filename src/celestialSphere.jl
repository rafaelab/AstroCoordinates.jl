export
	getEarthRotationAngle,
	computeEquinox


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Mean value of the orbit's
"""
const ε_ο = 84381.406 * u"arcsecond" |> u"°"

# ----------------------------------------------------------------------------------------------- #
#
@doc """
The Earth rotation angle (θ_ERA) refers to the planet's rotation starting at the celestial intermediate origin, at the celestial equator.
It is very close to the equinox of J2000.

# Reference (eq. 2.11)
	"The IAU Resolutions on Astronomical Reference Systems, Time Scales, and Earth Rotation Models"
	G. H. Kaplan
	US Naval Observatory Circular #179
	astro-ph/0602086
	https://aa.usno.navy.mil/downloads/Circular_179.pdf
"""
getEarthRotationAngle(jd::Real) = (mod(2π * (0.7790572732640 + 1.00273781191135448 * (jd - jd_2000)), 2π)) * u"rad" |> u"°"

# ----------------------------------------------------------------------------------------------- #
#
@doc """
The Earth rotation angle (θ_ERA) refers to the planet's rotation starting at the celestial intermediate origin, at the celestial equator.
It is very close to the equinox of J2000.
The usual representation is　E_Υ

# Reference (eq. 2.14)
	"The IAU Resolutions on Astronomical Reference Systems, Time Scales, and Earth Rotation Models"
	G. H. Kaplan
	US Naval Observatory Circular #179
	astro-ph/0602086
	https://aa.usno.navy.mil/downloads/Circular_179.pdf
"""
function computeEquinox(jd::Real; referenceJD::Real = jd_2000)
	Ω = computeMeanLongitudeMoonAscendingNode(jd; referenceJD = referenceJD)
	D = computeMeanElongationMoonSun(jd; referenceJD = referenceJD)
	F = computeMeanArgumentOfLatitudeMoon(jd; referenceJD = referenceJD)
	ε = computeNutationInObliquity(jd; referenceJD = referenceJD)
	Δψ = computeNutationInLongitude(jd; referenceJD = referenceJD)
	t = getNumberOfJulianCenturies(jd; referenceJD = referenceJD)

	E_Υ = ustrip(Δψ * cos(ε))
	E_Υ += 0.00264096 * sin(Ω)
	E_Υ += 0.00006352 * sin(2 * Ω)
	E_Υ += 0.00001175 * sin(2 * F - 2 * D + 3 * Ω)
	E_Υ += 0.00001121 * sin(2 * F - 2 * D + Ω)
	E_Υ -= 0.00000455 * sin(2 * F - 2 * D + 2 * Ω)
	E_Υ += 0.00000202 * sin(2 * F + 3 * Ω)
	E_Υ += 0.00000198 * sin(2 * F + Ω)
	E_Υ -= 0.00000172 * sin(3 * Ω)
	E_Υ -= 0.00000087 * sin(Ω) * t

	return E_Υ * u"arcsecond"
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
Helper function that takes the number of julian centuries and return a polynomial, considering N terms.

# Input
. `jd::Real`: julian date \\
. `coeff::Union{Tuple, AbstractVector}`: an iterable with the coefficients of the polynomial \\
"""
function evaluatePolynomialOfT(jd::Real, coeff::C; referenceJD::Real = jd_2000) where {C <: Union{AbstractVector, Tuple}}
	t = getNumberOfJulianCenturies(jd; referenceJD = referenceJD)
	f = createPolynomialFunction(coeff)
	return f(t)
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	computeMeanAnomalyMoon(julianDate; referenceJD = julianDate2000)

Calculate the mean anomaly of the moon.
It is defined as the fraction of an orbit elapsed since the periapsis.

# Reference (eq. 5.19; term named l)
	"The IAU Resolutions on Astronomical Reference Systems, Time Scales, and Earth Rotation Models"
	G. H. Kaplan
	US Naval Observatory Circular #179
	astro-ph/0602086
	https://aa.usno.navy.mil/downloads/Circular_179.pdf

# Input
. `jd::Real`: julian date \\
. `coeff::Union{Tuple, AbstractVector}`: an iterable with the coefficients of the polynomial \\
"""
computeMeanAnomalyMoon(jd::Real; referenceJD::Real = jd_2000) = evaluatePolynomialOfT(jd, (485868.249036, 1717915923.2178, 31.8792, 0.051635, - 0.00024470); referenceJD = referenceJD) * u"arcsecond"


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	computeMeanAnomalySun(julianDate; referenceJD = julianDate2000)

Calculate the mean anomaly of the Sun.
It is defined as the fraction of an orbit elapsed since the periapsis.

# Reference (eq. 5.19; term named l')
	"The IAU Resolutions on Astronomical Reference Systems, Time Scales, and Earth Rotation Models"
	G. H. Kaplan
	US Naval Observatory Circular #179
	astro-ph/0602086
	https://aa.usno.navy.mil/downloads/Circular_179.pdf

# Input
. `jd::Real`: julian date \\
. `coeff::Union{Tuple, AbstractVector}`: an iterable with the coefficients of the polynomial \\
"""
computeMeanAnomalySun(jd::Real; referenceJD::Real = jd_2000) =  evaluatePolynomialOfT(jd, (1287104.79305, 129596581.0481, -0.5532, 0.000136, -0.00001149); referenceJD = referenceJD) * u"arcsecond"


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	computeMeanArgumentOfLatitudeMoon(julianDate; referenceJD = julianDate2000)

The argument of latitude describes the angular parameter that defines the position of the Moon along its orbit.
It is essentially the angle between the ascending node and the body.

# Reference (eq. 5.19; term named F)
	"The IAU Resolutions on Astronomical Reference Systems, Time Scales, and Earth Rotation Models"
	G. H. Kaplan
	US Naval Observatory Circular #179
	astro-ph/0602086
	https://aa.usno.navy.mil/downloads/Circular_179.pdf

# Input
. `jd::Real`: julian date \\
. `coeff::Union{Tuple, AbstractVector}`: an iterable with the coefficients of the polynomial \\
"""
computeMeanArgumentOfLatitudeMoon(jd::Real; referenceJD::Real = jd_2000) = evaluatePolynomialOfT(jd, (335779.526232, 1739527262.8478,  -12.7512,  -0.001037, 0.00000417); referenceJD = referenceJD) * u"arcsecond"


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	computeMeanElongationMoonSun(julianDate; referenceJD = julianDate2000)

The angular separation between the Moon and the Sun along the orbit, with respect to a reference point (Earth).

# Reference (eq. 5.19; term named D)
	"The IAU Resolutions on Astronomical Reference Systems, Time Scales, and Earth Rotation Models"
	G. H. Kaplan
	US Naval Observatory Circular #179
	astro-ph/0602086
	https://aa.usno.navy.mil/downloads/Circular_179.pdf

# Input
. `jd::Real`: julian date \\
. `coeff::Union{Tuple, AbstractVector}`: an iterable with the coefficients of the polynomial \\
"""
computeMeanElongationMoonSun(jd::Real; referenceJD::Real = jd_2000) = evaluatePolynomialOfT(jd, (1072260.70369, 1602961601.2090, -6.3706, 0.006593, -0.00003169); referenceJD = referenceJD) * u"arcsecond"


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	computeMeanLongitudeMoonAscendingNode(julianDate; referenceJD = julianDate2000)

This quantity is related to where the Moon's orbit.
It is the point where the Moon moves into the northern ecliptic hemisphere. 

# Reference (eq. 5.19; term named ☊)
	"The IAU Resolutions on Astronomical Reference Systems, Time Scales, and Earth Rotation Models"
	G. H. Kaplan
	US Naval Observatory Circular #179
	astro-ph/0602086
	https://aa.usno.navy.mil/downloads/Circular_179.pdf

# Input
. `jd::Real`: julian date \\
. `coeff::Union{Tuple, AbstractVector}`: an iterable with the coefficients of the polynomial \\
"""
computeMeanLongitudeMoonAscendingNode(jd::Real; referenceJD::Real = jd_2000) = evaluatePolynomialOfT(jd, (450160.398036, -6962890.5431, 7.4722, 0.007702, -0.00005939); referenceJD = referenceJD) * u"arcsecond"

# ----------------------------------------------------------------------------------------------- #
#
@doc """
	computeMeanObliquityEcliptic(julianDate; referenceJD = julianDate2000)

This represents the inclination between the Earth's equator and the ecliptic.


# Reference (eq. 5.12; term named ε)
	"The IAU Resolutions on Astronomical Reference Systems, Time Scales, and Earth Rotation Models"
	G. H. Kaplan
	US Naval Observatory Circular #179
	astro-ph/0602086
	https://aa.usno.navy.mil/downloads/Circular_179.pdf

# Input
. `jd::Real`: julian date \\
. `coeff::Union{Tuple, AbstractVector}`: an iterable with the coefficients of the polynomial \\
"""
computeMeanObliquityEcliptic(jd::Real; referenceJD::Real = jd_2000) = ε_ο - evaluatePolynomialOfT(jd, (0., -46.836769, -0.0001831, 0.00200340, -0.000000576, -0.0000000434); referenceJD = referenceJD) * u"arcsecond"



# ----------------------------------------------------------------------------------------------- #
#
@doc """
	computeNutationInLongitude(julianDate; referenceJD = julianDate2000)

This computes the change in the axis of rotation of the Earth over time.
This implementation is NOT the most detailed one, following the IAU resolutions.
Instead, I only take the first-order terms.
The conventional representation of this term is: Δψ.

# Reference
	https://en.wikipedia.org/wiki/Astronomical_nutation

# Input
. `jd::Real`: julian date \\
. `coeff::Union{Tuple, AbstractVector}`: an iterable with the coefficients of the polynomial \\
"""
function computeNutationInLongitude(jd::Real; referenceJD::Real = jd_2000) 
	☊ = computeMeanLongitudeMoonAscendingNode(jd; referenceJD = referenceJD)
	return -17.2 * sin(☊) * u"arcsecond" |> u"°"
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	computeNutationInObliquity(julianDate; referenceJD = julianDate2000)

This computes the change in the axis of rotation of the Earth over time.
This implementation is NOT the most detailed one, following the IAU resolutions.
Instead, I only take the first-order terms.
The conventional representation of this term is: Δϵ.

# Reference
	https://en.wikipedia.org/wiki/Astronomical_nutation

# Input
. `jd::Real`: julian date \\
. `coeff::Union{Tuple, AbstractVector}`: an iterable with the coefficients of the polynomial \\
"""
function computeNutationInObliquity(jd::Real; referenceJD::Real = jd_2000) 
	☊ = computeMeanLongitudeMoonAscendingNode(jd; referenceJD = referenceJD)
	return 9.2 * sin(☊) * u"arcsecond" |> u"°"
end


# ----------------------------------------------------------------------------------------------- #