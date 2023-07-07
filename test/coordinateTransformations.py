import numpy as np
from astropy.coordinates import SkyCoord, EarthLocation, AltAz
from astropy.time import Time
from astropy import units as u

# reference values
v1 = SkyCoord(ra = 10.00 * u.degree, dec =  30.0 * u.degree, frame = 'icrs')
v2 = SkyCoord(ra = 179.0 * u.degree, dec = -89.0 * u.degree, frame = 'icrs')
v3 = SkyCoord(l = 45.0 * u.degree, b = -12.0 * u.degree, frame = 'galactic')

location = EarthLocation(lat = 50. * u.deg, lon = 10. * u.deg, height = 0. * u.m)
time = Time('1987-8-23 10:25:00') - 1. * u.hour

# conversions
v1_icrs = v1
v1_eq = v1.fk5
v1_gal = v1.galactic
v1_sg = v1.supergalactic
v1_hz = v1.transform_to(AltAz(obstime = time, location = location))
v2_icrs = v2
v2_eq = v2.fk5
v2_gal = v2.galactic
v2_sg = v2.supergalactic
v2_hz = v2.transform_to(AltAz(obstime = time, location = location))
v3_eq = v3.fk5
v3_icrs = v3.icrs
v3_sg = v3.supergalactic
v3_hz = v3.transform_to(AltAz(obstime = time, location = location))

# print information
def getICRS(u):
	return '%.8f°, %.8f°' % (u.ra.value, u.dec.value)
	
def getEquatorial(u):
	return '%.8f°, %.8f°' % (u.ra.value, u.dec.value)

def getGalactic(u):
	return '%.8f°, %.8f°' % (u.l.value, u.b.value)
	
def getSuperGalactic(u):
	return '%.8f°, %.8f°' % (u.sgl.value, u.sgb.value)

def getHorizontal(u):
	return '%.8f°, %.8f°' % (u.az.value, np.fmod(90. - u.alt.value, 180.) - 90.)


print('==> v1 = ', getICRS(v1.icrs))
print('  . equatorial = ', getEquatorial(v1_eq))
print('  . galactic = ', getGalactic(v1_gal))
print('  . supergalactic = ', getSuperGalactic(v1_sg))
print('  . horizontal = ', getHorizontal(v1_hz))

print('==> v2 = ', getICRS(v2))
print('  . equatorial = ', getEquatorial(v2_eq))
print('  . galactic = ', getGalactic(v2_gal))
print('  . supergalactic = ', getSuperGalactic(v2_sg))
print('  . horizontal = ', getHorizontal(v2_hz))

print('==> v3 = ', getGalactic(v3))
print('  . icrs = ', getICRS(v3_icrs))
print('  . equatorial = ', getEquatorial(v3_eq))
print('  . supergalactic = ', getSuperGalactic(v3_sg))
print('  . horizontal = ', getHorizontal(v3_hz))

